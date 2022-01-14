require 'rails_helper'

describe "the update a review process" do
  before(:each) do
    @user = User.create!({email:"me@me.com", password:"help123",password_confirmation:"help123", admin:true})
    visit '/'
    click_link 'Sign-In/Sign-Up'
    fill_in 'Email', :with => "me@me.com"
    fill_in 'Password', :with => "help123"
    click_on "Log in"
    visit products_path
    click_link 'Add a product'
    fill_in 'Name', :with => 'Canned olives'
    fill_in 'Cost', :with => 9.99
    fill_in 'Country of origin', :with => 'Spain'
    click_on 'Create Product'
    click_on 'Canned Olives'
    click_on 'Add a review'
    fill_in 'Author', :with => 'Morgan'
    fill_in 'Rating', :with => 4
    fill_in 'Content body', :with => 'It was awful terrible disgusting I hated it this item should not be sold it should be removed from all stores oh the horror of these disgusting olives never again will I buy them'
    click_on 'Create Review'
  end
  it "updates a review" do
    visit products_path
    click_on 'Canned Olives'
    click_on 'Review by Morgan'
    click_on 'Edit'
    fill_in 'Author', :with => 'Morgan'
    fill_in 'Rating', :with => 1
    fill_in 'Content body', :with => 'It was awful terrible disgusting I hated it this item should not be sold it should be removed from all stores oh the horror of these disgusting olives never again will I buy them'
    click_on 'Update Review'
    expect(page).to have_content 'Review updated successfully!'
  end
  it "updates a review" do
    visit products_path
    click_on 'Canned Olives'
    click_on 'Review by Morgan'
    click_on 'Edit'
    fill_in 'Author', :with => 'Morgan'
    fill_in 'Rating', :with => 1
    fill_in 'Content body', :with => 'It was bad'
    click_on 'Update Review'
    expect(page).to have_content 'There was an error in updating your review'
  end
end
