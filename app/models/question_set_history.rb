class QuestionSetHistory < ApplicationRecord
  belongs_to :question_set
  has_many :question_histories
  has_many :try_histories

  def self.latest
    order(:id).last
  end

  def create_try_history(choices, yourresults)
    history = try_histories.new(choices: choices)
    history.try_scores = yourresults.map { |result| TryScore.new(result) }
    history.save!
    history
  end
end
