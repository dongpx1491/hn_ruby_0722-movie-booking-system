module FavoritesHelper
  def favorited user, movie_id
    user.favorites.find_by movie_id: movie_id
  end
end
