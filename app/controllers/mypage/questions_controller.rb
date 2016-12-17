class Mypage::QuestionsController < MypageController
  def index
    @question = Question.new
    @question.scores.new
    @questions = current_user.questions
    gon.parties = Party.active(Time.zone.now).pluck(:id)
  end

  def show
    @question = current_user.questions.find(params[:id])
    gon.parties = @question.scores.pluck(:party_id)
  rescue
    redirect_to mypage_path
  end

  def create
    question_set = current_user.question_sets.find(params[:question][:question_set])
    question_set.add_question(question_params)
    redirect_to mypage_question_set_path(question_set)
  end

  def update
    @question = Question.find(params[:id])
    @question.update_attributes!(question_params)
    render 'show'
  end

  private

  def question_params
    params.require(:question).permit(
      :user, :title, scores_attributes: [:id, :party_id, :agree, :neutral, :opposition]
    )
  end
end
