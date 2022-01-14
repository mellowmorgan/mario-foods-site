# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all
Review.destroy_all
User.destroy_all
50.times do |index|
  product = Product.create!({name: Faker::Food.ingredient, cost: Faker::Number.within(range: 0.10..100.99), country_of_origin: Faker::Address.country})
  5.times do |index|
    Review.create!({author: Faker::Name.name, product_id: product.id, rating: Faker::Number.within(range: 1..5), content_body: Faker::Lorem.paragraph_by_chars(number: 100) })
  end
end
#set some usa products for homepage display
p1 = Product.find(1)
p1.country_of_origin = "United States of America"
p1.save
Product.find(2)
p2.country_of_origin = "United States of America"
p2.save
Product.find(3)
p3.country_of_origin = "United States of America"
p3.save

#give a product one more review to make it show on homepage "most review"
p1.reviews.create!({author: Faker::Name.name, product_id: product.id, rating: Faker::Number.within(range: 1..5), content_body: Faker::Lorem.paragraph_by_chars(number: 100)})

User.create!({email:"test@test.com", password:"testing", password_confirmation:"testing"})
User.create!({email:"admin@test.com", password:"testing", password_confirmation:"testing", admin:true})

p "Created #{Product.count} products"
p "Created #{Review.count} reviews"
p "Created #{User.count} users"