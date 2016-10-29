class Question < ApplicationRecord
  belongs_to :user
  has_many :scores, class_name: 'QuestionScore', dependent: :destroy
  accepts_nested_attributes_for :scores
end
