require "faker"

FactoryBot.define do
  factory :seat do |f|
    f.type_seat {rand(0..1)}
    f.price {"50" or "75"}
    room {FactoryBot.create :room}
    f.room_id {room_id.id}
  end
end
