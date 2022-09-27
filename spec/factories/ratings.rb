require "faker"

FactoryBot.define do
  factory :rating do |f|
    f.comment {Faker::Lorem.sentence(word_count: 10)}
    f.rate {nil}
    user {FactoryBot.create :user}
    movie {FactoryBot.create :movie}
    f.user_id {user.id}
    f.movie_id {movie.id}
  end
end
