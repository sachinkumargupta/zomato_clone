class Image < ApplicationRecord
  belongs_to :restaurant

  has_attached_file :photo, styles: { large: "600x600>", medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  validates :photo, attachment_presence: true
  validates :category, presence: true
  validates :category, inclusion: { in: %w(Food Restaurant Menu Other)}
end
