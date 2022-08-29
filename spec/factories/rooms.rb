require "faker"

FactoryBot.define do
  factory :room do |f|
    sequence(:name) {|n| "Cinema #{n + 1}"}
    f.total_seat {"28"}
  end
end
