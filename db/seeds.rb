# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# For User 
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

# For Restaurant 
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

# For Reviews
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

# For Image model
30.times do |n|
  category_array = %w(Food Restaurant Menu Other)
  category = category_array[rand(0..3)]
  Image.create!( category: category,
                 restaurant_id: rand(1..Restaurant.count),
                 photo: File.open("app/assets/images/images/#{n%7}.jpg"))
end


# For Food Item
#food_item_array = ["Aloo baingan masala","Aloo gobi","Aloo ki tikki","Aloo matar","Aloo methi","Aloo shimla mirch","Amriti with rabdi","Amritsari fish","Amritsari kulcha","Biryani","Butter chicken","Chaat","Chana masala","Chapati","Chicken razala","Chicken Tikka","Chole bhature","Daal puri","Dum aloo","Gajar ka halwa","Jalebi","Kofta","Pani puri","Paratha","Samosa"]
food_item_array = ["Aloo gobi","Fish","Biryani","Chaat","Chana masala","Chapati","Chicken razala","Chicken Tikka","Chole bhature","Gajar ka halwa","Jalebi","Kofta","Pani puri","Paratha","Samosa"]
restaurant_count = Restaurant.count
restaurant_count.times do |n|
  10.times do |m|
    name = food_item_array[m]
    FoodItem.create!( name: name,
                      price: rand(100..200).round(-1),
                      restaurant_id: n+1)
  end
end

# For Order model
user_count = User.count
restaurant_count.times do |n|
  5.times do |m|
    item_array = "1, 2, 3, 4, 5"
    quantity_array = "#{rand(1..5)}, #{rand(1..5)}, #{rand(1..5)}, #{rand(1..5)}, #{rand(1..5)}"
    quantity = quantity_array.split(', ').map(&:to_i)
    delivery_address = "#{Faker::Address.street_address} #{Faker::Address.city} #{Faker::Address.state} #{Faker::Address.country}"
    price = FoodItem.find([1,2,3,4,5]).pluck(:price)
    total = 0
    5.times do |i|
      total += quantity[i] * price[i]
    end

    Order.create!( item_array: item_array,
                   quantity_array: quantity_array,
                   delivery_address: delivery_address,
                   total: total,
                   restaurant_id: n+1,
                   user_id: rand(1..user_count))
  end
end

# For Booking
restaurant_count.times do |n|
  rand(5..10).times do 
    date =  DateTime.now.utc + rand(0..1).months + rand(1..12).hours + rand(1..60).minutes
    duration_array = ["30 min", "1 hour", "1:30 hour", "2 hours"]

    BookTable.create!( date: date,
                       headcount: rand(1..10),
                       duration: duration_array[rand(0..3)],
                       user_id: rand(1..user_count),
                       restaurant_id: n+1)
  end
end