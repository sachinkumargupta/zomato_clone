class CreateFoodItems < ActiveRecord::Migration[5.1]
  def change
    create_table :food_items do |t|
      t.string :name
      t.integer :price
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
