class Mypage::QuestionsController < MypageController
  def index
    @question = Question.new
    @question.scores.new
    @questions = current_user.questions
    gon.parties = Party.active.pluck(:id)
  end

  def show
  end

  def create
    @question = current_user.questions.new(question_params)
    @question.save
    redirect_to mypage_questions_path
  end

  def create_scores
    Rails.logger.debug("SSSSSSS1:"+params.inspect)
    respond_to do |format|
      format.json { render json: { status: 'success' } }
      format.html { redirect_to :back, notice: 'Like was successfully created.' }
    end
  end

  private

  def question_params
    params.require(:question).permit(
      :user, :title, scores_attributes: [:party_id, :agree, :neutral, :opposition]
    )
  end
end
