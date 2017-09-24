class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true

  has_attached_file :cover_photo, styles: { large: "600x600>", medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :cover_photo, content_type: /\Aimage\/.*\z/
  validates :cover_photo, attachment_presence: true

  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :food_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :book_tables, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  before_save do 
    self.location_url = "https://www.google.com/maps/preview/@#{latitude},#{longitude},10z" unless location_url.present?
  end

  scope :search_with_keywords, ->(key) { where(["name like ? or
                                           address like ? or 
                                           restaurant_type like ?","%#{key}%","%#{key}%","%#{key}%"])}

  scope :filter_based_on_type, ->(key) {where(["restaurant_type like ?","%#{key}%"])}
end
