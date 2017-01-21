class QuestionSetHistory < ApplicationRecord
  belongs_to :question_set
  has_many :question_histories
  has_many :try_histories

  def find_or_create_try_history(choice_params, yourresults)
    history = try_histories.where(choices: choice_params).latest
    return history if history.present?

    history = try_histories.new(choices: choice_params)
    history.try_scores = yourresults.map { |result| TryScore.new(result) }
    history.save!
    history
  end
end
