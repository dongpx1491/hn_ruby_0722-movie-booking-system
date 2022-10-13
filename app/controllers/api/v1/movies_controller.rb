class Api::V1::MoviesController < Api::BaseController
  before_action :authenticate_user!, :find_movie, only: :show

  def show
    @pagy, @ratings = pagy @movie.ratings.latest
    render json: {
      data: {
        movie: ActiveModelSerializers::SerializableResource.new(
          @movie, each_serializer: MovieSerializer
        )
      },
      message: ["Movie fetched successfully"],
      status: 200,
      type: "Success",
      ratings: @ratings,
      pagination: @pagy
    }
  end

  def sort
    @pagy, @movies = pagy @search.result.latest
    render json: {
      data: {
        movies: ActiveModelSerializers::SerializableResource.new(
          @movies, each_serializer: MovieSerializer
        )
      },
      message: ["Movies list fetched successfully"],
      status: 200,
      type: "Success",
      pagination: @pagy
    }
  end

  private

  def find_movie
    @movie = Movie.find_by id: params[:id]
    return if @movie

    render json: {
      message: ["Not found movie"],
      status: 400,
      type: "Fail"
    }
  end
end
