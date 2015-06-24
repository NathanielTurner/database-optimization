class EmailBlasterJob < ActiveJob::Base
  queue_as :default

  def perform(name)
    @assembly = Assembly.where(name: name)
    @hits = Hit.where(subject_id: Gene.where(
      sequence_id: Sequence.where(
      assembly_id: Assembly.where(
      name: params[:name])))).order(:percent_similarity)
  end
end
