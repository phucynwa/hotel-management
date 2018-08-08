User.create! name: "Admin", email: "admin@gmail.com", phone: "0243 585 2568",
  role: 2, password: "123123", password_confirmation: "123123",
  activated: true, activated_at: Time.zone.now

User.create! name: "Staff", email: "staff@gmail.com", phone: "0243 256 2548",
  role: 1, password: "123123", password_confirmation: "123123",
  activated: true, activated_at: Time.zone.now

50.times do
  User.create! name: Faker::Name.unique.name,
    email: Faker::Internet.unique.free_email,
    phone: Faker::PhoneNumber.phone_number,
    password: "123123",
    password_confirmation: "123123",
    activated: true,
    activated_at: Time.zone.now,
    role: 0
end

10.times do
  Category.create! name: Faker::Lorem.characters(5),
    price: (Random.rand(1000000) / 100) * 100,
    description: Faker::Lorem.paragraph(5)
end

40.times do
  label = Faker::Lorem.characters(5)
  floor = Random.rand(15) + 1
  status = Random.rand(5) + 1
  category_id = Random.rand(10) + 1
  Room.create! label: label, floor: floor,
    status: status, category_id: category_id
end

50.times do
  user_id = Random.rand(50) + 1
  start_time = Time.zone.now.days_ago(3)
  end_time = Time.zone.now
  status = Random.rand(5) + 1
  Booking.create! user_id: user_id, start_time: start_time, end_time: end_time,
    status: status
end

50.times do
  user_id = Random.rand(50) + 1
  content = Faker::Lorem.sentence
  status = "1"
  priority = Random.rand(4) + 1
  Request.create! user_id: user_id,content: content, status: status,
    priority: priority
end

50.times do
  user_id = Random.rand(50) + 1
  content = Faker::Lorem.sentence
  Rating.create! user_id: user_id, content: content
end

40.times do
  room_id = Random.rand(40) + 1
  image_link = Faker::Avatar.image(slug = nil, size = '730x411',
    format = 'png', bgset = true)
  Image.create! image_link: image_link, room_id: room_id
end
