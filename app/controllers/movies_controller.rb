class MoviesController < ApplicationController
  before_action :find_movie, only: :show
  authorize_resource

  def show
    @pagy, @ratings = pagy @movie.ratings.latest,
                           items: Settings.page.comment
  end

  def sort
    @pagy, @movies = pagy @search.result.latest,
                          link_extra: 'data-remote="true"'
    respond_to :js
  end

  private

  def find_movie
    @movie = Movie.find_by id: params[:id]
    return if @movie

    flash[:warning] = t "not_found"
    redirect_to root_path
  end
end
