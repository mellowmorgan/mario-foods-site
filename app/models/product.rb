class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :cost, presence: true
  validates :country_of_origin, presence: true
  before_save(:titleize_product)
  before_save(:shave_cost_decimals)
  scope :search_products, -> (name_parameter) { }

  def self.search_products(parameter)
    where("name || country_of_origin ILIKE ?", "%#{parameter}%")
  end

  scope :most_reviews, -> {(
    select("products.id, products.name, products.cost, products.country_of_origin, count(reviews.id) as reviews_count")
    .joins(:reviews)
    .group("products.id")
    .order("reviews_count DESC")
    .limit(1).first
    )}
  scope :most_recently_added, -> { order(created_at: :desc).limit(3)}
  scope :made_in_usa, -> { where(country_of_origin: "United States of America") }

  private
    def titleize_product
      self.name = self.name.titleize
    end
    
  private
    def shave_cost_decimals
      self.cost = self.cost.round(2)
    end
end

