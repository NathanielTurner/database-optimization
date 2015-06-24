class ReportsController < ApplicationController
  def all_data
    @assembly = Assembly.where(name: params[:name])
    @hits = Hit.where(subject_id: Gene.where(
      sequence_id: Sequence.where(
      assembly_id: Assembly.where(
      name: params[:name])))).order(:percent_similarity)
  end
end
