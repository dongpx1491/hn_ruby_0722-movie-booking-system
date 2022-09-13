FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.unique.email}
    password {"password"}
    password_confirmation {"password"}
    date_of_birth {"2001/04/01"}
    role {0}
    phone_number {"0123456789"}
  end
end
