require "faker"

FactoryBot.define do
  factory :genre do
    sequence(:name) {|n| Faker::Lorem.word + n.to_s}
  end
end
