class PaymentsController < ApplicationController
  before_action :load_payment, :check_expiration, only: %i(show activation)
  authorize_resource

  def show
    @tickets = @payment.tickets
    render :non_payment if @tickets.blank?
  end

  def activation
    ActivePaymentWorker.perform_async @payment.id
    flash[:info] = t ".info"
    redirect_to payment_path(current_payment)
  end

  def destroy
    delete_payment if have_payment?
    @payment = Payment.find_by id: params[:id]
    if @payment.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end

    render :non_payment
  end

  private

  def load_payment
    @payment = current_payment
    return if @payment

    flash[:danger] = t ".danger"
    redirect_to root_path
  end

  def check_expiration
    return unless @payment.payment_expired?

    delete_payment
    flash[:danger] = t ".danger"
    redirect_to root_path
  end
end
