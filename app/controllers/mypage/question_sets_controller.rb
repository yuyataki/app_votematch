class Mypage::QuestionSetsController < MypageController
  def index
    @question_set = QuestionSet.new
    @question_sets = current_user.question_sets
  end

  def show
    @question_set = current_user.question_sets.find(params[:id])
    @question = Question.new
    @question.scores.new
    @questions = current_user.questions
    gon.parties = Party.active.pluck(:id)
  end
end
