class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :cost, presence: true
  validates :country_of_origin, presence: true
  before_save(:titleize_product)

  scope :most_reviews, -> {(
    select("products.id, products.name, products.cost, products.country_of_origin, count(reviews.id) as reviews_count")
    .joins(:reviews)
    .group("products.id")
    .order("reviews_count DESC")
    .limit(1).first
    )}
  scope :most_recently_added, -> { order(created_at: :desc).limit(3)}
  scope :made_in_usa, -> { where(country_of_origin: "USA") }

  #method determines if all products have same review count
  def self.same_review_count?
    array_count_reviews = select("products.id, products.name, products.cost, products.country_of_origin, count(reviews.id) as reviews_count")
    .joins(:reviews)
    .group("products.id")
    .order("reviews_count DESC")
    last_count = array_count_reviews[0].reviews_count
    array_count_reviews.each do |product|
      if (product.reviews_count!=last_count)
        return false
      end
    end 
    true
  end
  
  private
    def titleize_product
      self.name = self.name.titleize
    end
end

