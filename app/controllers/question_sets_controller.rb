class QuestionSetsController < ApplicationController
  def show
    @question_set = QuestionSet.find(params[:id])
    gon.question_ids = @question_set.questions.pluck(:id)
  end

  def yourresult
    @question_set = QuestionSet.find(params[:id]).decorate
    @your_results = @question_set.results(params[:choice])

    question_set_history = @question_set.histories.latest
    @try_history = question_set_history.create_try_history(params[:choice], @your_results)

    gon.parties_points = @your_results.map { |r| [r[:party].id, r[:total], r[:percentage]] }
  end
end
