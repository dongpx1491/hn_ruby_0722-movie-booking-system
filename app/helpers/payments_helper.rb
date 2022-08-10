module PaymentsHelper
  def init_payment payment
    session[:payment_id] = payment.id
  end

  def current_payment
    @current_payment ||= Payment.find_by id: session[:payment_id]
  end

  def have_payment?
    current_payment.present?
  end

  def delete_payment
    session.delete :payment_id
    @current_payment = nil
  end

  def total_price ticket
    total = current_payment.total + ticket.seat.price
    current_payment.update_attribute(:total, total)
  end
end
