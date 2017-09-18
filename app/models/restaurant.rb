class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true

  has_attached_file :cover_photo, styles: { large: "600x600>", medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :cover_photo, content_type: /\Aimage\/.*\z/

  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :food_items, dependent: :destroy
  has_many :orders, dependent: :destroy
end
