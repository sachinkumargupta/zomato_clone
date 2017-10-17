class AddCategoryToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :category, :string
  end
end
