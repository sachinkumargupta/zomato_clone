class AddRatingToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :rating, :integer
  end
end
