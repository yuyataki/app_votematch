class Mypage::QuestionsController < MypageController
  def index
    @question = Question.new
    @question.scores.new
    @questions = current_user.questions
  end

  def show
  end

  def create
    @question = current_user.questions.new(question_params)
    @question.save
    redirect_to mypage_questions_path
  end

  private

  def question_params
    params.require(:question).permit(
      :user, :title, scores_attributes: [:party_id, :agree, :neutral, :opposition]
    )
  end
end
