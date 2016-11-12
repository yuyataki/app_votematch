class Mypage::FavoritesController < MypageController
  def index
    @favorite_sets = current_user.favorite_sets
  end
end
