class QuestionSet < ApplicationRecord
  belongs_to :user
  has_many :question_set_relationships
  has_many :questions, through: :question_set_relationships

  enum status: { invisible: 0, visible: 1 }

  def add_question(params)
    questions.new(params.merge(user: user))
    save
  end

  def result(choice_params)
    Party.joins(:scores).includes(:scores).merge(
      QuestionScore.of_question(questions)
    ).map do |party|
      {
        party: party,
        total: party.scores.reduce(0) { |sum, s| sum + s.send(choice_params[s.question_id.to_s]) },
      }
    end
  end

  def saved_questions
    questions.select(&:persisted?)
  end
end
