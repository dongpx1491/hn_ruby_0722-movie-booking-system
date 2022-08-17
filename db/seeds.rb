Genre.create!([{name: 'Horror'}, {name: 'Comedy'}, {name: 'Action'}, {name: 'Adventure'}, {name: 'Fantasy'}])

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
  duration = Faker::Time.between(from: "01:59:59", to: "03:59:59")
  language = Faker::Nation.language
  thumbnail = Faker::Avatar.image
  cast = Faker::Artist.unique.name
  director = Faker::Artist.unique.name
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
<<<<<<< HEAD
=======

3.times do |n|
  name = "Cinema #{n + 1}"
  Room.create!(name: name, total_seat: 28)
end

3.times do |n|
  id = n + 1
  room = Room.find id
  (room.total_seat - 10).times do
    Seat.create!(type_seat: 0, price: 50, room_id: room.id)
  end
  10.times do
    Seat.create!(type_seat: 1, price: 75, room_id: room.id)
  end
end

3.times do
  date = Faker::Date.between(from: "2022-07-23", to: "2021-09-25")
  rd = rand(10..22)
  start_time = "#{rd}:00:00"
  Show.create!(date: date,
              start_time: start_time,
              movie_id: Movie.active.pluck(:id).sample,
              room_id: Room.all.pluck(:id).sample)
end
>>>>>>> 76a79e6 (Add ticket to payment)
