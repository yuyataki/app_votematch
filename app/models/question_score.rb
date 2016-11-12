class QuestionScore < ApplicationRecord
  SCORES = [*0..9].map { |num| [num, num] }.map(&:freeze).freeze

  belongs_to :question
  belongs_to :party
end
