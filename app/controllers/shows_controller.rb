class ShowsController < ApplicationController
  before_action :find_movie
  authorize_resource

  def index
    @search_show = @movie.shows.ransack(params[:q])
    if @search_show.sorts.empty?
      @search_show.sorts = ["date asc", "start_time asc"]
    end
    @pagy, @shows = pagy @search_show.result.date_available
  end

  def show
    unless check_payment?
      delete_payment
      @payment = Payment.create user_id: current_user.id
      init_payment @payment
    end
    @show = @movie.shows.find_by id: params[:id]
    @seats = @show.room.seatsasdasdasdasd
  end

  private
asdasdasdasdasd
  def find_movie
    @movie = Movie.find_by id: params[:movie_id]
    return if @movie

    flash[:warning] = t ".not_found"
    redirect_to root_path
  end
end
