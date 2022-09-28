class ApplicationController < ActionController::Base
  include PaymentsHelper
  include FavoritesHelper
  include Pagy::Backend
  protect_from_forgery prepend: true, except: :sort

  before_action :set_locale, :ransack_movie
  rescue_from CanCan::AccessDenied, with: :deny_access
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
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
      stored_location_for(resource) || root_url
    end
  end
end
