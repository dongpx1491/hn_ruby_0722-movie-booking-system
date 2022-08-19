class ShowsController < ApplicationController
  before_action :find_movie
  before_action :logged_in_user, only: :show

  def index
    @pagy, @shows = pagy @movie.shows.asc_date.asc_time
  end

  def show
    unless have_payment?
      @payment = Payment.create user_id: session[:user_id]
      init_payment @payment
    end
    @show = @movie.shows.find_by id: params[:id]
    @seats = @show.room.seats
  end

  private

  def find_movie
    @movie = Movie.find_by id: params[:movie_id]
    return if @movie

    flash[:warning] = t ".not_found"
    redirect_to root_path
  end
end
