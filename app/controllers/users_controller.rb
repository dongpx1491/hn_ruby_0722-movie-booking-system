class UsersController < ApplicationController
  before_action :find_user, :correct_user, only: %i(edit update)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_email"
      redirect_to login_url
    else
      flash[:danger] = t "danger"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".success"
      redirect_to edit_user_path
    else
      flash[:danger] = t ".danger"
      render :edit
    end
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t ".warning"
    redirect_to root_path
  end

  def correct_user
    return if current_user? @user

    flash[:danger] = ".danger"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit User::USER_ATTRS
  end
end
