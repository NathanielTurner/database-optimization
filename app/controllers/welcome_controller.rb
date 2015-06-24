class WelcomeController < ApplicationController
  def welcome
  end

  def thank_you
    @email = params[:email]
    @name = params[:name]
#   EmailBlasterJob.perform_later(params[:name])
    HitsMailer.report(@email, @name).deliver_now
  end
end
