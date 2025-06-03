require "faker"
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
GoalCompletion.destroy_all
Goal.destroy_all
GroupMembership.destroy_all
Group.destroy_all
User.destroy_all

puts "Database cleaned."

puts "Creating Users..."
20.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = Faker::Internet.username
  email = Faker::Internet.email(domain: '@lewagon.com')
  password = Faker::Internet.password(min_length: 8)

  User.create!(
    first_name: first_name,
    last_name: last_name,
    username: username,
    email: email,
    password: password
  )

  puts "Email: #{email}, Password: #{password}, Username: #{username}"
end

puts 'Created 20 users'
