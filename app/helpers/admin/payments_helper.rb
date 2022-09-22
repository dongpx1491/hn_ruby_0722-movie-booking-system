module Admin::PaymentsHelper
  def check_expired payment
    Payment.check_expire(payment.id, payment.created_at).present?
  end

  def number_booked_seat show
    show.tickets.count
  end

  def total_seat show
    show.room.seats.count
  end
end
