class Mypage::QuestionSetsController < MypageController
  after_action :clear_session_errors

  def show
    @question_set = current_user.question_sets.find(params[:id])
    @parties = @question_set.parties
    @question = @question_set.questions.new
    @question.scores.new

    gon.parties = @parties.pluck(:id)
  rescue
    redirect_to mypage_path
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
