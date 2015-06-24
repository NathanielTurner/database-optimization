class HitsMailer < ApplicationMailer
  def report(email, name)
    @greeting = "Hi Im a robot!!!!!!!!!!!!!!ROOOBOOOOT."
    @assembly = Assembly.where(name: name)
    @hits = Hit.where(subject_id: Gene.where(
      sequence_id: Sequence.where(
      assembly_id: Assembly.where(
      name: name)))).order(:percent_similarity)
    mail to: email
  end
end
