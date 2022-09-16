class StaticPagesController < ApplicationController
  def home
    @pagy, @movies = pagy @search.result.latest
    @genres = Genre.asc_genre_name
  end
end
