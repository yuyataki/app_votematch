class TryHistory < ApplicationRecord
  has_one :user_try_history_relationship
  has_one :user, through: :user_try_history_relationship
  has_many :try_scores
  belongs_to :question_set_history
end
