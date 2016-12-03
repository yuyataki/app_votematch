class Mypage::QuestionSetsController < MypageController
  def show
    @question_set = current_user.question_sets.find(params[:id])

    @question = @question_set.questions.new
    @question.scores.new

    @saved_questions = @question_set.saved_questions

    gon.parties = Party.active.pluck(:id)
  end

  def create
    question_set = current_user.question_sets.create!(question_set_params)
    redirect_to mypage_question_set_path(question_set)
  end

  private

  def question_set_params
    params.require(:question_set).permit(:user, :title)
  end
end
