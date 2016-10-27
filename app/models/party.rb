class Party < ApplicationRecord
  has_many :question_scores

  enum status: { inactive: 0, active: 1 }
end
