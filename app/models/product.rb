class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :cost, presence: true
  validates :country_of_origin, presence: true
  before_save(:titleize_product)
  
  # scope :most_reviews, -> { order(created_at: :desc).limit(1)} returns 1 product
  scope :most_recently_added, -> { order(created_at: :desc).limit(3)}
  # scope :made_in_usa 
  scope :made_in_usa, -> { where(country_of_origin: "USA") }
  #returns arrays of all products with usa country of origin 
  
  private
    def titleize_product
      self.name = self.name.titleize
    end
end


# The product with the most reviews.
# The three most recently added products.
# All products made in the USA for buyers that want to buy local products.