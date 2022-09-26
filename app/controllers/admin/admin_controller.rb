class Admin::AdminController < ApplicationController
  include Admin::PaymentsHelper
  include Admin::UsersHelper
  before_action :is_admin?
  layout "admin/layouts/application"

  private
  def is_admin?
    return admin_root_path if current_user.admin?

    flash[:danger] = t ".cannot_access_to_this_page"
    redirect_to root_path
  end
end
