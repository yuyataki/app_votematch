class QuestionSetsController < ApplicationController
  def show
    @question_set = QuestionSet.find(params[:id])
    gon.question_ids = @question_set.questions.pluck(:id)
  end

  def yourresult
    @question_set = QuestionSet.find(params[:id])
    @your_results = @question_set.results(params[:choice])
    gon.parties_points = @your_results.map { |r| [r[:party].id, r[:total], r[:percent]] }
  end
end
