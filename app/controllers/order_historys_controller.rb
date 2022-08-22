class OrderHistorysController < ApplicationController
  def index
    @payments = current_user.payments
    if @payments.present?
      @pagy, @payments = pagy current_user.payments.show_active.latest
    else
      flash[:info] = t ".info"
    end
  end

  def show
    @payment = Payment.find_by id: params[:id]
    if @payment.present?
      @tickets = @payment.tickets
    else
      flash[:danger] = t ".danger"
      redirect_to order_historys_path
    end
  end
end
