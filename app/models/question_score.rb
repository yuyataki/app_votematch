class QuestionScore < ApplicationRecord
  SCORES = [*0..10].map { |num| [num, num] }.map(&:freeze).freeze

  belongs_to :question
  belongs_to :party

  scope :of_question, ->(question) { where(question: question) }

  def max_point
    [agree, neutral, opposition].max
  end
end
