class Question < ApplicationRecord
  belongs_to :user
  has_many :question_scores
  accepts_nested_attributes_for :question_scores
end
