require "faker"

FactoryBot.define do
  factory :favorite do |f|
    user {FactoryBot.create :user}
    movie {FactoryBot.create :movie}
    f.user_id {user.id}
    f.movie_id {movie.id}
  end
end
