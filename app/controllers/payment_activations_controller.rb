class PaymentActivationsController < ApplicationController
  before_action :load_payment, only: :edit

  def edit
    if !@payment.active? && @payment.authenticated?(params[:id])
      @payment.activate_payment
      delete_payment if have_payment?
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to root_path
  end

  private

  def load_payment
    @payment = Payment.find_by id: params[:payment_id]
    return if @payment

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
