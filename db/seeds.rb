# Create Users
8.times do
  password = Faker::Internet.password
  User.create!(
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password
  )
end
User.create!(
  email: 'adminuser@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld',
  role: 'admin'
)
User.create!(
  email: 'premiumuser@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld',
  role: 'premium'
)

users = User.all

# Create Wikis
100.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    user: users.sample
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} users created"
