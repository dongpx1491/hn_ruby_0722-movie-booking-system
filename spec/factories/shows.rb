require "faker"

FactoryBot.define do
  factory :show do |f|
    f.date {Faker::Date.between(from: "2022-07-23", to: "2022-10-30")}
    f.start_time {Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all)}
    movie {FactoryBot.create :movie, status: :active}
    room {FactoryBot.create :room}
    f.movie_id {movie_id.id}
    f.room_id {room_id.id}
  end
end
