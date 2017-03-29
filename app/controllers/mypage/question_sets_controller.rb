class Mypage::QuestionSetsController < MypageController
  after_action :clear_session_errors, only: %i(show)

  def show
    @question_set = current_user.question_sets.find(params[:id]).decorate
    @parties = @question_set.parties
    @question = @question_set.questions.new
    @question.scores.new

    gon.parties = @parties.pluck(:id)
  rescue
    redirect_to mypage_path
  end

  def create
    question_set = current_user.question_sets.new(question_set_params)

    if question_set.save
      redirect_to mypage_question_set_path(question_set)
    else
      session[:errors] = question_set.errors.full_messages
      redirect_to mypage_path
    end
  end

  def histories
    @histories = current_user.question_sets.find(params[:id]).histories.order(:id)
  end

  def update
    question_set = current_user.question_sets.find(params[:id])
    question_set.attributes = question_set_params

    redirect_back(fallback_location: mypage_path)
    session[:errors] = question_set.errors.full_messages unless question_set.save
  end

  def destroy
    current_user.question_sets.find(params[:id]).destroy
    redirect_to mypage_path
  end

  private

  def question_set_params
    params.require(:question_set).permit(:user, :title, :status)
  end
end
