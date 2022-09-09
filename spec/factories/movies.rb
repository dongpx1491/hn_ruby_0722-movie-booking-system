require "faker"

FactoryBot.define do
  factory :movie do |f|
    f.title {Faker::Movie.title}
    f.description {Faker::Lorem.sentence(word_count: 50)}
    f.release_date {Faker::Date.between(from: "2023-01-23", to: "2023-09-30")}
    f.language {Faker::Book.publisher}
    f.duration {Faker::Number.between(from: 60, to: 300)}
    f.thumbnail {Faker::Avatar.image}
    f.cast {Faker::Artist.unique.name}
    f.director {Faker::Artist.unique.name}
    f.status {rand(0..1)}
    genre {FactoryBot.create :genre}
    f.genre_id {genre.id}
  end
end
