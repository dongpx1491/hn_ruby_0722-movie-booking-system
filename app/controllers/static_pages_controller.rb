class StaticPagesController < ApplicationController
  def home
    @movies = Movie.active.limitation
  end
end
