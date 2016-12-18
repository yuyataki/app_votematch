class QuestionSetsController < ApplicationController
  def show
    @question_set = QuestionSet.find(params[:id])
    gon.question_ids = @question_set.questions.pluck(:id)
  end

  def yourresult
    @question_set = QuestionSet.find(params[:id])
    @yourresult = @question_set.result(params[:choice])
    redirect_to :back
  end
end
