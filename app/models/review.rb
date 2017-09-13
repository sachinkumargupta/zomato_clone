class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :rating, presence: true
  validates_numericality_of :rating, less_than_or_equal_to: 5
end
