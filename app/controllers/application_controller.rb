class ApplicationController < ActionController::Base
  include PaymentsHelper
  include FavoritesHelper
  include Admin::PaymentsHelper
  include Pagy::Backend
  attr_reader :current_user

  # protect_from_forgery prepend: true, except: :sort

  before_action :set_locale, :ransack_movie
  rescue_from CanCan::AccessDenied, with: :deny_access
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def authenticate_request!
    unless user_id_in_token?
      render json: {errors: ["Not Authenticated"]}, status: :unauthorized
      return
    end
    @current_user = User.find auth_token[:user_id]
  rescue JWT::VerificationError, JWT::DecodeError
    render json: {errors: ["Not Authenticated"]}, status: :unauthorized
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def http_token
    @http_token ||= if request.headers["Authorization"].present?
                      request.headers["Authorization"].split(" ")[1]
                    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end

  def configure_permitted_parameters
    added_signup_attrs = %i(name phone_number email password
                         password_confirmation)
    added_update_attrs = %i(name date_of_birth phone_number email password
                         password_confirmation)

    devise_parameter_sanitizer.permit :sign_up, keys: added_signup_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_update_attrs
  end

  def deny_access
    flash[:danger] = t "access_denied"
    redirect_to root_url
  end

  def ransack_movie
    @search = Movie.ransack(params[:m])
  end

  def after_sign_in_path_for resource
    flash[:success] = t ".sign_in_successful"
    if resource.admin?
      admin_root_path
    else
      flash[:danger] = t ".cannot_access_to_this_page"

      stored_location_for(resource) || root_url
    end
  end
end
