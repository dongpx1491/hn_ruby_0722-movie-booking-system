class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate params[:session][:password]
      remember_handle user
    else
      excep_handle
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
      redirect_back_or root_path
    end
  end

  def remember_handle user
    if user.activated?
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      log_in user
      logged_in user
    else
      flash[:warning] = t ".message"
      redirect_to login_url
    end
  end

  def excep_handle
    flash.now[:danger] = t ".danger"
    render :new
  end
end
