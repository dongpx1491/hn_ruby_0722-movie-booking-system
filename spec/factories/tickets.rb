require "faker"

FactoryBot.define do
  factory :ticket do |f|
    show {FactoryBot.create :show}
    payment {FactoryBot.create :payment}
    seat {FactoryBot.create :seat}
    f.show_id{show.id}
    f.payment_id{payment.id}
    f.seat_id{seat.id}
  end
end
