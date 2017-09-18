class Order < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates :item_array, presence: true
  validates :quantity_array, presence: true
  validates :delivery_address, presence: true
end
