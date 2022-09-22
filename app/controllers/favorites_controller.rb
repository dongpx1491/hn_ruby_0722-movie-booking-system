class FavoritesController < ApplicationController
  authorize_resource class: false

  def index
    @pagy, @movies = pagy current_user.movies
  end

  def create
    current_user.favorites.create movie_id: params[:id]
    respond_to :js
  end

  def destroy
    @favorite = current_user.favorites.find_by(id: params[:id])
    if @favorite
      @favorite.destroy
      respond_to :js
    else
      redirect_to movie_path(params[:id])
    end
  end
end
