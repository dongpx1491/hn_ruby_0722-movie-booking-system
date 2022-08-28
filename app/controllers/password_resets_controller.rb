class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration,
                only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase

    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".info"
      redirect_to new_password_reset_path
    else
      flash.now[:danger] = t ".danger"
      render :new
    end
  end

  def update
    if params[:user][:password].blank?
      @user.errors.add :password, t(".empty")
      render :edit
    elsif @user.update user_params
      flash[:success] = t ".success"
      redirect_to login_path
    else
      excep_handle
    end
  end

  def edit; end

  private
  def except_handle
    flash[:danger] = t ".danger"
    render :edit
  end

  def load_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t ".not_found"
    redirect_to root_url
  end

  def valid_user
    return if @user&.activated? && @user&.authenticated?(:reset, params[:id])

    redirect_to root_path
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t ".danger"
    redirect_to new_password_reset_url
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end
end
