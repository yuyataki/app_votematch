class QuestionSet < ApplicationRecord
  belongs_to :user
  has_many :question_set_relationships
  has_many :questions, through: :question_set_relationships

  enum status: { invisible: 0, visible: 1 }

  def add_question(params)
    questions.new(params.merge(user: user))
    save
  end

  def saved_questions
    questions.select(&:persisted?)
  end
end
