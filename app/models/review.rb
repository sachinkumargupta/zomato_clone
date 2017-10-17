class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  has_attached_file :photo, styles: { large: "600x600>", medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
  
  validates :rating, presence: true
  validates_numericality_of :rating, less_than_or_equal_to: 5
end
