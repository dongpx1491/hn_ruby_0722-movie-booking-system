class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate params[:session][:password]
      log_in user
      logged_in user
    else
      flash.now[:danger] = t ".danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def logged_in user
    if user.admin?
      redirect_to admin_root_path
    else
      redirect_to root_path
    end
  end
end
