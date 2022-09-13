class Admin::UsersController < Admin::AdminController
  before_action :find_user, :load_payment, only: %i(show)
  authorize_resource

  def index
    @pagy, @users = pagy User.customer.incre_order
  end

  def show
    respond_to :js
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "not_found"
    redirect_to admin_users_path
  end

  def load_payment
    @payments = @user.payments
    return if @payments

    flash[:danger] = t "not_found"
    redirect_to admin_users_path
  end
end
