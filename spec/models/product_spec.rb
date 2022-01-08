require 'rails_helper'

describe Product do
  it { should have_many(:reviews)}
  it { should validate_presence_of :cost }
  it { should validate_presence_of :name }
  it { should validate_presence_of :country_of_origin }
  it("titleizes the name of a product") do
    product = Product.create({name: "canned fancy olives", cost: 5.99, country_of_origin: "Spain"})
    expect(product.name()).to(eq("Canned Fancy Olives"))
  end
  describe ('.most_recently_added') do
    it("returns 3 most recently added products") do
      product1 = Product.create({name: "canned olives", cost: 3.99, country_of_origin: "Italy"})
      product2 = Product.create({name: "vegan cheddar", cost: 5.99, country_of_origin: "USA"})
      product3 = Product.create({name: "pink artichokes", cost: 5.99, country_of_origin: "Italy"})
      product4 = Product.create({name: "red wine", cost: 1.99, country_of_origin: "France"})
      product5 = Product.create({name: "black bean tempeh", cost: 5.99, country_of_origin: "USA"})
      expect(Product.most_recently_added).to(eq([product5,product4,product3]))
    end
  end
  describe ('.made_in_usa') do
    it("returns all products made in usa") do
      product1 = Product.create({name: "canned olives", cost: 3.99, country_of_origin: "Italy"})
      product2 = Product.create({name: "vegan cheddar", cost: 5.99, country_of_origin: "USA"})
      product3 = Product.create({name: "pink artichokes", cost: 5.99, country_of_origin: "Italy"})
      product4 = Product.create({name: "red wine", cost: 1.99, country_of_origin: "France"})
      product5 = Product.create({name: "black bean tempeh", cost: 5.99, country_of_origin: "USA"})
      expect(Product.made_in_usa).to(eq([product2, product5]))
    end
  end
  describe ('.most_reviews') do
    it("returns product with most reviews") do
      product1 = Product.create({name: "canned olives", cost: 3.99, country_of_origin: "Italy"})
      product2 = Product.create({name: "vegan cheddar", cost: 5.99, country_of_origin: "USA"})
      product3 = Product.create({name: "pink artichokes", cost: 5.99, country_of_origin: "Italy"})
      review1 = Review.create({author: "Morgan", rating: 5, product_id:product1.id, content_body: "Hi wehrkwjehr ewhrkwehrkjh wer wher hwekhrwehr hw rkhkewhr whrkwherkwhr h wrhkwherjkw  wh"})
      review2 = Review.create({author: "Morgan W", rating: 4, product_id:product2.id, content_body: "Hi wehrkwjehr ewhrkwehrkjh wer wher hwekhrwehr hw rkhkewhr whrkwherkwhr h wrhkwherjkw  wh"})
      review3 = Review.create({author: "Morgan P", rating: 2,product_id:product1.id, content_body: "Hi wehrkwjehr ewhrkwehrkjh wer wher hwekhrwehr hw rkhkewhr whrkwherkwhr h wrhkwherjkw  wh"})
      expect(Product.most_reviews).to(eq(product1))
    end
  end
  
end