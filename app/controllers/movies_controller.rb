class MoviesController < ApplicationController
  before_action :find_movie, only: :show

  def show; end

  def sort
    if params[:sort]
      @pagy, @movies = sort_by params[:sort]
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
      pagy Movie.active.latest, link_extra: 'data-remote="true"'
    when :coming
      pagy Movie.inactive.latest, link_extra: 'data-remote="true"'
    when :all
      pagy Movie.all.latest, link_extra: 'data-remote="true"'
    end
  end
end
