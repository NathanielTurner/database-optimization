# Database Optimizations

## Description

Given an existing application which generates a report from a large data set, I will attempt to improve the efficiency of the report using database optimization methods, which include
* Creating indices where appropriate for the data.
* Improving how the controller handles rendering data obtained from the database.
* Exploration on improving the size of the database through various methods won in a google-fu tournament.

## Normal Mode

I will be starting with an application which runs very slowly.  This inefficiency is due partly to the sheer amount of data present, but mostly due to the structure of the code and the database.

##### I have taken a given codebase, migrated it, than ran its seed which will generate a massive amount of data.
* Step one - Record amount of time taken to seed database.
 * Time taken - 2286.3 seconds::38.11 minutes

##### Considering the controller action that opens the root page accepts a name parameter, I search for any assembly name and pop a1 into the controllers action. To record the load-time of the page I use chromes timeline in developer tools.
* Time taken to load page - 2.8 minutes

##### Adding indices to the data should greatly improve loadtime for the page. The indices I use are as follows.
* Add index sequence_id to genes table.
* Add index name to assemblies table.
* Add index assembly_id to sequences table.
* Add index subject-id to hits table.
* Add index subject_type to hits table.

##### I then run a rake db:migrate and record the time it takes to complete this migration.
* Time to complete migration - 5.1664 seconds

##### After the migration I load the page again and using chromes developer tools, I determin the new load time and calculate the percent improvement over the unindexed page loadtime.
* New load time after index migration - 6.1 minutes
* Percent change - 119 % increase in runtime
** I think my indices might be written wrong, but Im not sure.

##### Although the improvement is large, I still believe there is room for more improvement via modification of the code in the controller action. The modification rout i choose to take is to remove n+1 quarrying and rewrite the code to run in the same way but primarily within the database using as little ruby as possible. Once done I reopen the webpage and recaulcuate the runtime and determine the runtime differences.
* New runtime after code refactor - 2.15 seconds
* Percent improvement over non indexed and non refactored code - 7714 % improvement in runtime
* Percent improvement upon indexed but non refactored code- 16923.3 % improvement in runtime

##### To get a better understanding of what these changes will do to the time it takes to seed the database I drop the databse than remigrate it.
* Time taken for seeds to complete with the changed code- 2597.1 second::43.3 minutes
* Percent change in seed time - 13.6 % increase in seed time
* Observation - Indexes will increase the amount of time it takes to record data. running the seed before adding indices seems to be a faster option. migrating indices to seeded data took 5 seconds where as seeding indexed data took many minutes longer than non-indexed.

##### Lastly, generating such a massive database is bound to take a lot of space. For instance the space my seeded database took followed by the space of the log, is as follows
* Database size - 577.4 MB
* Log size - 2.2 GB
* One way I found to reduce the database size was that you could actually compress the databases rows or columns. For example, a column with an integer type that stores the id for the data piece would be allocated 4 bytes of space whether it used it or not( an id of 255 would use approximately one byte of space). Compressing this would eliminate all but the required 1 byte of space allocated to that id field, for every id.

##### My impression of how this compares to what I expect in the field.

I believe this could be an average sized database. I also feel it would pale in comparison to databases running things like Facebook.
