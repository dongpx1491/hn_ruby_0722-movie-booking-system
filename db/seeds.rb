5.times do
  name = Faker::Book.unique.genre
  Genre.create! name: name
end

User.create!(
  name: "Admin User",
  email: "admin@gmail.com",
  password: "password",
  password_confirmation: "password",
  role: 1,
  date_of_birth: "2001/04/01",
  phone_number: "0589122355"
)

User.create!(
  name: "User",
  email: "user@gmail.com",
  password: "password",
  password_confirmation: "password",
  date_of_birth: "2001/04/01",
  role: 0,
  phone_number: "0123456789"
)

20.times do
  title = Faker::Movie.unique.title
  description = Faker::Lorem.sentence(word_count: 50)
  release_date = Faker::Date.between(from: "2010-09-23", to: "2021-09-15")
  duration = Faker::Time.between(from: "01:59:59", to: "3:59:59")
  language = Faker::Number.between(from: 50, to: 100)
  thumbnail = Faker::Avatar.image
  cast = Faker::Name.unique.name
  director = Faker::Name.unique.name
  status = rand(0..1)
  Movie.create!(title: title,
               description: description,
               release_date: release_date,
               duration: duration,
               language: language,
               cast: cast,
               thumbnail: thumbnail,
               director: director,
               status: status,
               genre_id: Genre.all.pluck(:id).sample)
end
