# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# for User 
User.create!(name:  "Sachin Kumar",
             email: "sachin1@gmail.com",
             password:              "sachin",
             password_confirmation: "sachin",
             admin: true)

User.create!(name:  "Sachin",
             email: "sachin2@gmail.com",
             password:              "password",
             password_confirmation: "password")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end


# for Restaurant 
10.times do |n|
  name = Faker::Company.name
  address = "#{Faker::Address.street_address} #{Faker::Address.city} #{Faker::Address.state} #{Faker::Address.country}"
  lat = Faker::Address.latitude
  long = Faker::Address.longitude
  location_url = "https://www.google.co.in/maps/place/Barbeque+Nation/@22.582488,88.4091699,13z/data=!4m8!1m2!2m1!1sbarbequee!3m4!1s0x3a0275adc3ba1021:0xebcdcaa065bd0c8!8m2!3d22.568943!4d88.433181"
  type = %w(Fast\ food Dining Barbeque Buffet Cafe Destination\ restaurant pub)
  restaurant_type = type[rand(0..6)]
  
  Restaurant.create!(name: name,
                     address: address,
                     lat: lat,
                     long: long,
                     location_url: location_url)
end
