require "faker"

FactoryBot.define do
  factory :payment do |f|
    user {FactoryBot.create :user}
    f.total {Faker::Commerce.price(range: 1..100.0)}
    f.status {rand(0..1)}
    f.user_id {user.id}
    f.activation_digest {Faker::Internet.password}
    f.activated_at {Time.now-15}
  end
end
