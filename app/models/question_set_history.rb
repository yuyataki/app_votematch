class QuestionSetHistory < ApplicationRecord
  belongs_to :question_set
  has_many :question_histories

  def self.latest
    order(:id).last
  end
end
