class MoviesController < ApplicationController
  before_action :find_movie, only: :show

  def index; end

  def show; end

  private

  def find_movie
    @movie = Movie.find_by id: params[:id]
    return if @movie

    flash[:warning] = t ".not_found"
    redirect_to root_path
  end
end
