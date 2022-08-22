class MoviesController < ApplicationController
  before_action :find_movie, only: :show

  def index; end

  def show; end

  def sort
    if params[:sort]
      @movies = sort_by params[:sort]
      respond_to :js
    else
      redirect_to root_path
    end
  end

  private

  def find_movie
    @movie = Movie.find_by id: params[:id]
    return if @movie

    flash[:warning] = t "not_found"
    redirect_to root_path
  end

  def sort_by params
    case params.to_sym
    when :showing
      Movie.active.limitation
    when :coming
      Movie.inactive.limitation
    end
  end
end
