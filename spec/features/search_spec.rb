require 'rails_helper'

describe "make a search process" do
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
    expect(page).to have_content 'Product added successfully!'
    expect(page).to have_content 'Canned Olives'
  end
  it("shows product from search") do
    visit '/'
    fill_in "Search", :with => "olives"
    click_on "Search"
    expect(page).to have_content "Canned Olives"
  end
end