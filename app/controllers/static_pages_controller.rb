class StaticPagesController < ApplicationController
  def home
    @pagy, @movies = pagy Movie.search params[:search]
    @genres = Genre.asc_genre_name
  end
end
