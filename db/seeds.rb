User.create! name: "Admin", email: "admin@gmail.com", phone: "0243 585 2568",
  role: 2, password: "123123", password_confirmation: "123123",
  activated: true, activated_at: Time.zone.now

User.create! name: "Staff", email: "staff@gmail.com", phone: "0243 256 2548",
  role: 1, password: "123123", password_confirmation: "123123",
  activated: true, activated_at: Time.zone.now

50.times do
  User.create! name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    phone: Faker::PhoneNumber.phone_number,
    password: "123123",
    password_confirmation: "123123"
    activated: true
    activated_at: Time.zone.now
end

users = User.order(:created_at).take 6
10.times do
  start_time = Faker::Time.between(Time.zone.now - 3, Time.zone.now)
  end_time = Time.zone.now
  status = "1"
  users.each {|user| user.bookings.create! start_time: start_time,
    end_time: end_time}
end

10.times do
  content = Faker::Lorem.sentence
  status = "1"
  priority = Faker::Number.number 1
  users.each {|user| user.requests.create! content: content, status: status,
    priority: priority}
end

10.times do
  content = Faker::Lorem.sentence
  users.each {|user| user.ratings.create! content: content}
end

10.times do
  Category.create! name: Faker::Lorem.characters(5),
    price: Faker::Number.number(6),
    description: Faker::Lorem.paragraph(5)
end

categories = Category.order(:created_at).take 6
20.times do
  label = Faker::Lorem.characters(5)
  floor = Faker::Number.number 2
  status = Faker::Number.number 1
  categories.each {|category| category.rooms.create! label: label, floor: floor,
    status: status}
end
