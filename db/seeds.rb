# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# for User 
User.create!(name:  "Sachin Admin",
             email: "sachin1@gmail.com",
             password:              "sachin",
             password_confirmation: "sachin",
             admin: true)

98.times do |n|
  name  = Faker::Name.name
  email = "sachin#{n+2}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# for Restaurant 
6.times do |n|
  name = Faker::Company.name
  address = "#{Faker::Address.street_address} #{Faker::Address.city} #{Faker::Address.state} #{Faker::Address.country}"
  lat = Faker::Address.latitude
  long = Faker::Address.longitude
  location_url = "https://www.google.com/maps/preview/@#{lat},#{long},15z"
  type = %w(Fast\ food Dining Barbeque Buffet Cafe Destination\ restaurant Pub)
  restaurant_type = type[rand(0..6)]
  
  Restaurant.create!(name: name,
                     address: address,
                     lat: lat,
                     long: long,
                     location_url: location_url,
                     restaurant_type: restaurant_type,
                     cover_photo: File.open("app/assets/images/restaurant/#{n+1}.jpg"))
end

# for Reviews
30.times do |n|
  rating = rand(1..5)
  comment = Faker::Movie.quote
  user_id = rand(1..User.count)
  user = User.find(user_id)
  restaurant_id = rand(1..Restaurant.count)
  
  if (user_id == 1 || n % 2 == 0) 
    approved = true
  else
    approved = false
  end
  
  Review.create!( rating: rating, 
                  comment: comment,
                  approved: approved,
                  user_id: user_id,
                  restaurant_id: restaurant_id)
end

# for Image model
30.times do |n|
  category_array = %w(Food Restaurant Menu Other)
  category = category_array[rand(0..3)]
  Image.create!( category: category,
                 restaurant_id: rand(1..Restaurant.count),
                 photo: File.open("app/assets/images/images/#{n%7}.jpg"))
end


# for Food Item
food_item_array = ["Aloo baingan masala","Aloo gobi","Aloo ki tikki","Aloo matar","Aloo methi","Aloo shimla mirch","Amriti with rabdi","Amritsari fish","Amritsari kulcha","Biryani","Butter chicken","Chaat","Chana masala","Chapati","Chicken razala","Chicken Tikka","Chole bhature","Daal puri","Dum aloo","Gajar ka halwa","Jalebi","Kofta","Pani puri","Paratha","Samosa"]


50.times do |n|
  name = food_item_array[rand(0..24)]
  price = rand(100..200).round(-1)

  FoodItem.create!( name: name,
                    price: rand(100..200).round(-1),
                    restaurant_id: rand(1..Restaurant.count))
   
end