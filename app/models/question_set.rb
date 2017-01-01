class QuestionSet < ApplicationRecord
  belongs_to :user
  has_many :question_set_relationships
  has_many :questions, through: :question_set_relationships
  has_many :try_histories
  has_many :histories, class_name: 'QuestionSetHistory'

  enum status: { invisible: 0, visible: 1 }

  after_update :create_question_set_history_for_update

  validates :title, presence: true

  def parties
    questions.find(&:persisted?).try(:parties) || Party.active(Time.zone.now)
  end

  def add_question(params)
    questions.new(params.merge(user: user))
    save! if valid?
    create_question_set_history
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
    questions.eager_load(scores: :party).select(&:persisted?)
  end

  def create_question_set_history_for_update
    return if questions.blank?
    return unless changed? || questions.any?(&:changed?)
    create_question_set_history
  end

  def create_question_set_history
    return if !status_changed? && invisible?

    question_set_history = histories.new(title: title)
    question_histories = questions.map do |question|
      QuestionHistory.new(title: question.title, scores: question.scores_to_hash)
    end
    question_set_history.question_histories = question_histories
    question_set_history.save!
  end
end
