module Admin::PaymentsHelper
  def check_expired payment
    Payment.check_expire(payment.id, payment.created_at).present?
  end

  def revenue show
    revenue = 0
    @tickets = show.tickets
    @tickets.each do |ticket|
      revenue += ticket.seat.price if ticket.payment.active?
    end
    revenue
  end

  def number_booked_seat show
    show.tickets.count
  end

  def total_seat show
    show.room.seats.count
  end
end
