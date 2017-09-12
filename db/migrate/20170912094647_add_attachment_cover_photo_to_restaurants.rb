class AddAttachmentCoverPhotoToRestaurants < ActiveRecord::Migration[5.1]
  def self.up
    change_table :restaurants do |t|
      t.attachment :cover_photo
    end
  end

  def self.down
    remove_attachment :restaurants, :cover_photo
  end
end
