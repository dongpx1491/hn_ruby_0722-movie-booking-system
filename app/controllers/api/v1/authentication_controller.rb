module Api
  module V1
    class AuthenticationController < BaseController
      def sign_up
        user = User.find_by email: params[:email]
        if user.valid_password? params[:password]
          generate_token user
          render json: {message: "Login successfully",
                        success: true, data: @data}, status: :ok
        else
          render json: {message: "Invalid email or password combination",
                        success: false}, status: :unauthorized
        end
      end

      private

      def generate_token user
        access_token = JsonWebToken.encode(user_id: user.id)
        @data = {
          access_token: access_token,
          token_type: "Bearer"
        }
      end
    end
  end
end
