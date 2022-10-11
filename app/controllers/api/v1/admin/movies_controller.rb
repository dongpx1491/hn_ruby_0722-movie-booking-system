module Api
  module V1
    class Admin::MoviesController < BaseController
      before_action :find_movie, only: :show
      before_action :authenticate_user!

      def index
        @movies = Movie.active
        render json: {
          data: {
            movies: ActiveModelSerializers::SerializableResource.new(
              @movies, each_serializer: MovieSerializer
            )
          },
          message: ["Active movies list fetched successfully"],
          status: 200,
          type: "Success"
        }
      end

      def show
        render json: {
          data: {
            movies: ActiveModelSerializers::SerializableResource.new(
              @movie, each_serializer: MovieSerializer
            )
          },
          message: ["Movie fetched successfully"],
          status: 200,
          type: "Success"
        }
      end

      private

      def movie_params
        params.require(:movie).permit Movie::MOVIE_ATTR
      end

      def find_movie
        @movie = Movie.find_by id: params[:id]
        return if @movie

        flash[:danger] = t "not_found"
        redirect_to root_path
      end

      def load_genre
        @genres = Genre.asc_genre_name
      end
    end
  end
end
