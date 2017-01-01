class Question < ApplicationRecord
  MIN_PARTIES_COUNT = 2

  belongs_to :user
  has_many :question_set_relationships
  has_many :question_sets, through: :question_set_relationships
  has_many :scores, class_name: 'QuestionScore', dependent: :destroy
  has_many :parties, through: :scores

  accepts_nested_attributes_for :scores

  before_update :make_question_set_invisible

  validates :title, presence: true
  validate :check_parties_count, :check_question_and_party

  def scores_to_hash
    scores.map do |score|
      { score.party_id => score.attributes.slice('agree', 'neutral', 'opposition') }
    end
  end

  private

  def parties_count
    scores.length
  end

  def distinct_parties_count
    scores.map(&:party_id).uniq.length
  end

  def check_parties_count
    errors.add(:parties_count, :not_less_than_two) if parties_count < MIN_PARTIES_COUNT
  end

  def check_question_and_party
    errors.add(:distinct_parties_count, :not_duplicate) if parties_count != distinct_parties_count
  end

  def make_question_set_invisible
    return unless changed?
    question_sets.each(&:invisible!)
  end
end
