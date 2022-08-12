class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      redirect_to new_user_path
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit User::USER_ATTRS
  end
end
