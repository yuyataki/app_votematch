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

  def update
    question_set = current_user.question_sets.find(params[:id])
    question_set.attributes = question_set_params

    if question_set.status_changed?
      redirect_to mypage_path
    elsif question_set.title_changed?
      redirect_to mypage_question_set_path(question_set)
    end
    question_set.save!
  end

  def update_title
    question_set = current_user.question_sets.find(params[:id])
    question_set.update(question_set_params)

    redirect_to mypage_path
  end

  private

  def question_set_params
    params.require(:question_set).permit(*%i(user title status))
  end
end
