class Question < ApplicationRecord
  belongs_to :user
  has_many :question_set_relationships
  has_many :question_sets, through: :question_set_relationships
  has_many :scores, class_name: 'QuestionScore', dependent: :destroy

  accepts_nested_attributes_for :scores
end
