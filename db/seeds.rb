Genre.create!([{name: 'Horror'}, {name: 'Comedy'}, {name: 'Action'}, {name: 'Adventure'}, {name: 'Fantasy'}])

User.create!(
  name: "Admin",
  email: "admin@gmail.com",
  password: "password",
  password_confirmation: "password",
  role: 1,
  date_of_birth: "2001/04/01",
  phone_number: "0589122355",
  activated: true,
  activated_at: Time.zone.now
)

User.create!(
  name: "User",
  email: "user@gmail.com",
  password: "password",
  password_confirmation: "password",
  date_of_birth: "2001/04/01",
  role: 0,
  phone_number: "0123456789",
  activated: true,
  activated_at: Time.zone.now
)

20.times do
  title = Faker::Movie.unique.title
  description = Faker::Lorem.sentence(word_count: 50)
  release_date = Faker::Date.between(from: "2010-09-23", to: "2021-09-15")
  duration = Faker::Number.between(from: 60, to: 300)
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

5.times do
  date = Faker::Date.between(from: "2022-07-23", to: "2022-09-30")
  rd = rand(10..22)
  start_time = "#{rd}:00:00"
  Show.create!(date: date,
              start_time: start_time,
              movie_id: Movie.active.pluck(:id).sample,
              room_id: Room.all.pluck(:id).sample)
end

Show.create!(date: "2022-08-23",
            start_time: "20:20",
            movie_id: Movie.active.pluck(:id).sample,
            room_id: Room.all.pluck(:id).sample,
            end_time: "22:00"
)
10.times do
  name = Faker::Name.unique.name_with_middle
  email = Faker::Internet.email(name: name)
  date_of_birth = Faker::Date.between(from: "2001-07-23", to: "2002-09-30")
  User.create!(
    name: name,
    email: email,
    password: "password",
    password_confirmation: "password",
    date_of_birth: date_of_birth,
    role: 0,
    phone_number: '0931230911'
  )
end
