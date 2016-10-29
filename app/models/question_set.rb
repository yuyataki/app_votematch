class QuestionSet < ApplicationRecord
  belongs_to :user

  enum status: { invisible: 0, visible: 1 }
end
