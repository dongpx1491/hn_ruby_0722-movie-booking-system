class Admin::PaymentsController < Admin::AdminController
  before_action :find_payment, except: %i(index)
  before_action :load_ticket, only: %i(show)
  authorize_resource

  def index
    @pagy, @payments = pagy Payment.incre_order
  end

  def show
    respond_to :js
  end

  def edit; end

  def update
    if @payment.update(status: payment_params["status"].to_i)
      flash[:success] = t "payment_update"
    else
      flash[:danger] = t "payment_update_failed"
    end
    redirect_to admin_payments_path
  end

  def destroy
    if @payment.destroy
      flash[:success] = t "payment_delete"
    else
      flash[:danger] = t "payment_delete_failed"
    end
    redirect_to admin_payments_path
  end

  private
  def payment_params
    params.require(:payment).permit(:status)
  end

  def find_payment
    @payment = Payment.find_by id: params[:id]
    return if @payment

    flash[:danger] = t "not_found"
    redirect_to admin_payments_path
  end

  def load_ticket
    @tickets = @payment.tickets
    return if @tickets

    flash[:danger] = t "not_found"
    redirect_to admin_payments_path
  end
end
