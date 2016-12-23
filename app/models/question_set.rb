class QuestionSet < ApplicationRecord
  belongs_to :user
  has_many :question_set_relationships
  has_many :questions, through: :question_set_relationships

  enum status: { invisible: 0, visible: 1 }

  def parties
    questions.select(&:persisted?).first.try(:parties) || Party.active(Time.zone.now)
  end

  def add_question(params)
    questions.new(params.merge(user: user))
    save! if valid?
  end

  def results(choice_params)
    Party.joins(:scores).includes(:scores).merge(
      QuestionScore.of_question(questions)
    ).map do |party|
      total = party.scores.reduce(0) { |sum, s| sum + s.send(choice_params[s.question_id.to_s]) }
      { party: party, total: total, percent: 100 * total / (10 * questions.count) }
    end
  end

  def saved_questions
    questions.select(&:persisted?)
  end
end
