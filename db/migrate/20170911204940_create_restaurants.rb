class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :address
      t.decimal :lat
      t.decimal :long
      t.text :location_url
      t.string :restaurant_type

      t.timestamps
    end
  end
end
