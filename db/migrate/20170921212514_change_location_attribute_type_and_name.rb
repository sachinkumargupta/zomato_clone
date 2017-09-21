class ChangeLocationAttributeTypeAndName < ActiveRecord::Migration[5.1]
  def up
    change_column :restaurants, :lat, :float
    change_column :restaurants, :long, :float
    rename_column :restaurants, :lat, :latitude
    rename_column :restaurants, :long, :longitude

  end
  def down
    rename_column :restaurants, :latitude, :lat
    rename_column :restaurants, :longitude, :long
    change_column :restaurants, :lat, :decimal
    change_column :restaurants, :lat, :decimal
  end
end
