class GenresController < ApplicationController
  before_action :find_genre, only: :show
  before_action :load_movie, only: :show
  authorize_resource

  def show
    respond_to :js
  end

  private

  def find_genre
    @genre = Genre.find_by id: params[:id]

    return if @genre

    flash[:warning] = t ".not_found"
    redirect_to root_path
  end

  def load_movie
    @pagy, @movies = pagy @genre.movies, link_extra: 'data-remote="true"'
  end
end
