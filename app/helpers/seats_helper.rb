module SeatsHelper
  def is_booking? seat, show_id
    seat.ticket&.find_by(show_id: show_id)
  end
end
