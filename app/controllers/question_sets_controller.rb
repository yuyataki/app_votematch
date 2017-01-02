class QuestionSetsController < ApplicationController
  before_action :set_question_set, only: %i(show yourresult)
  before_action :redirect_to_show_page, only: :yourresult

  def show
    gon.question_ids = @question_set.questions.pluck(:id)
  end

  def yourresult
    @your_results = @question_set.results(params[:choice])

    question_set_history = @question_set.histories.latest
    @try_history = question_set_history.find_or_create_try_history(params[:choice], @your_results)

    gon.parties_points = @your_results.map { |r| [r[:party].id, r[:total], r[:percentage]] }
  end

  private

  def set_question_set
    @question_set = QuestionSet.find(params[:id]).decorate
  end

  def redirect_to_show_page
    if params[:choice].blank? || params[:choice].to_unsafe_h.size != @question_set.questions.size
      flash[:error] = '選択してください'
      redirect_back(fallback_location: question_set_path(@question_set))
    end
  end
end
