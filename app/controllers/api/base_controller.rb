module Api
  class BaseController < ActionController::API
    include Pagy::Backend
    include ExceptionHandler
    include UsersHelper
    before_action :ransack_movie

    protected

    def authenticate_user!
      token = request.headers["Authorization"].split(" ")[1]
      user_id = JsonWebToken.decode(token)["user_id"] if token
      @current_user = User.find_by id: user_id
      return if @current_user

      render json: {
        message: ["You need to log in to see the information"],
        status: 401,
        type: "failure"
      }, status: :unauthorized
    end

    def ransack_movie
      @search = Movie.ransack(params[:m])
    end
  end
end
