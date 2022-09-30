class FavoritesController < ApplicationController
  authorize_resource
  before_action :authenticate_user!

  def index
    @pagy, @movies = pagy current_user.movies.latest
  end

  def create
    current_user.favorites.create movie_id: params[:id]
    respond_to :js
  end

  def destroy
    @favorite = current_user.favorites.find_by(id: params[:id])
    params[:id] = params[:movie_id]
    if @favorite
      @favorite.destroy
      respond_to :js
    else
      redirect_to movie_path(params[:id])
    end
  end
end
