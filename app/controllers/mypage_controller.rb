class MypageController < ApplicationController
  before_action :redirect_to_root

  def index
  end

  def show
  end

  private

  def redirect_to_root
    redirect_to root_path unless user_signed_in?
  end
end
