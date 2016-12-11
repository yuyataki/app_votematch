class QuestionSetsController < ApplicationController
  def show
    @question_set = QuestionSet.find(params[:id])
    gon.question_ids = @question_set.questions.pluck(:id)
  end
end
