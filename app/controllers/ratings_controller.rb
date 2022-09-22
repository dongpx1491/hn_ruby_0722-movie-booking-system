class RatingsController < ApplicationController
  before_action :authenticate_user!, :find_movie
  authorize_resource

  def create
    @rating = current_user.ratings.build(movie_id: params[:movie_id],
                                         comment: params[:rating][:comment])
    @status = @rating.save
    @ratings = @movie.ratings.latest.top
    respond_to do |format|
      format.html{redirect_to movie_path(@movie)}
      format.js
    end
  end

  private

  def find_movie
    @movie = Movie.find_by id: params[:movie_id]
    return if @movie

    flash[:warning] = t "not_found"
    redirect_to root_path
  end
end
