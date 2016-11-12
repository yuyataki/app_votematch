class Mypage::QuestionSetsController < MypageController
  def index
    @question_set = QuestionSet.new
    @question_sets = current_user.question_sets
  end

  def show
    @question_set = current_user.question_sets.find(params[:id])

    @question = @question_set.questions.new
    @question.scores.new

    @saved_questions = @question_set.saved_questions

    gon.parties = Party.active.pluck(:id)
    gon.question_scores = @saved_questions.pluck(:id)
  end

  def add
  end
end
