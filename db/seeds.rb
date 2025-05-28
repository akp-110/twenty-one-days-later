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
User.destroy_all

puts "Database cleaned."

puts "Creating Users..."
10.times do
  email = Faker::Internet.unique.email
  password = Faker::Internet.password(min_length: 8)

  User.create!(
    email: email,
    password: password
  )

  puts "Email: #{email}, Password: #{password}"
end

puts 'Created 10 users'
