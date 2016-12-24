class MypageController < ApplicationController
  before_action :redirect_to_root

  after_action :clear_session_errors, only: %i(index)

  def index
    @question_set = QuestionSet.new
    @question_sets = current_user.question_sets.decorate
  end

  def show
  end

  private

  def redirect_to_root
    redirect_to root_path unless user_signed_in?
  end
end
