class Mypage::QuestionSetsController < MypageController
  def index
  end

  def show
    @question_set = current_user.question_sets.find(params[:id])
    @questions = current_user.questions
  end
end
