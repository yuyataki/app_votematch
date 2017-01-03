class TryHistory < ApplicationRecord
  has_one :user, through: :user_try_history_relationships
  has_many :question_sets
  has_many :try_scores
end
