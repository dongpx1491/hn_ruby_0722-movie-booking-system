class Admin::AdminController < ApplicationController
  layout "admin/layouts/application"

  private
  def is_admin?
    return admin_root_path if current_user.admin?

    redirect_to login_path
  end
end
