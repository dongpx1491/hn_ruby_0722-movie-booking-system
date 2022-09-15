class ApplicationController < ActionController::Base
  include PaymentsHelper
  include Pagy::Backend
  protect_from_forgery prepend: true

  before_action :set_locale
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
    added_attrs = %i(name date_of_birth phone_number email password
                  password_confirmation remember_me)

    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def deny_access
    flash[:danger] = t "access_denied"
    redirect_to root_url
  end
end
