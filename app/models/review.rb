class Review < ApplicationRecord
  belongs_to :product
  validates :author, presence: true
  validates :content_body, presence: true
  validates :rating, presence: true
  validates :rating, :inclusion => 1..5
  validates_length_of :content_body, minimum: 50
  validates_length_of :content_body, maximum: 250
end