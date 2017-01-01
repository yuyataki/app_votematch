class QuestionSetHistory < ApplicationRecord
  belongs_to :question_set
  has_many :question_histories
  has_many :try_histories

  def self.latest
    order(:id).last
  end

  def find_or_create_try_history(choices, yourresults)
    history = try_histories.where(choices: choices).latest
    return history if history.present?

    history = try_histories.new(choices: choices)
    history.try_scores = yourresults.map { |result| TryScore.new(result) }
    history.save!
    history
  end
end
