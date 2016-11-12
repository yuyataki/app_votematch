class QuestionSetRelationship < ApplicationRecord
  belongs_to :question_set
  belongs_to :question
end
