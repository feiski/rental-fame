# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Offer: title, description, date & price
# Reservation: comment & accepted (but false by default)
# User: Email & password
require 'faker'

puts 'Database cleaning...'
Reservation.destroy_all
Offer.destroy_all
User.destroy_all
puts 'Offer, Reservation & User destroyed...sic...'
puts 'Loading please wait...'

20.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 6)
  )
end
puts 'Users created'

10.times do
  offer_loop = Offer.create!(
    title: Faker::Movie.title,
    description: Faker::Book.title,
    date: Faker::Date.in_date_period,
    price: rand(100..500),
    user: User.all.sample
  )
  rand(1..5).times do
    Reservation.create!(
      offer: offer_loop,
      comment: Faker::Book.title,
      user: User.all.sample
    )
  end
end
puts 'Offers created & some reservations too'
puts 'Loading completed! GG!'
