class CreateBookTables < ActiveRecord::Migration[5.1]
  def change
    create_table :book_tables do |t|
      t.datetime :date
      t.integer :headcount
      t.string :duration
      t.references :user, foreign_key: true
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
