require "faker"

FactoryBot.define do
  factory :discount do |f|
    f.code {Faker::Code.asin}
    f.rate {rand(0.1..1.0)}
    f.condition {Faker::Lorem.sentence(word_count: 5)}
  end
end
