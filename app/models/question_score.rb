class QuestionScore < ApplicationRecord
  SCORES = [*0..10].map { |num| [num, num] }.map(&:freeze).freeze
  TOTAL_SCORE = 10

  belongs_to :question
  belongs_to :party

  validate :check_total_score

  scope :of_question, ->(question) { where(question: question) }

  def max_point
    [agree, neutral, opposition].max
  end

  private

  def total_score
    [agree, neutral, opposition].map(&:to_i).sum
  end

  def check_total_score
    errors.add(:total_score, :be_ten_points) unless total_score == TOTAL_SCORE
  end
end
