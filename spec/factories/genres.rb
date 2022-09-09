require "faker"

FactoryBot.define do
  factory :genre do |f|
    f.name {Faker::Sports::Football.unique.team}
  end
end
