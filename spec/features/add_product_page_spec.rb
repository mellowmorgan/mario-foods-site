require 'rails_helper'

describe "the add a product process" do
  before(:each) do
    @user2 = User.create!({email:"test@me.com", password:"help123",password_confirmation:"help123", admin:false})
    @user = User.create!({email:"me@me.com", password:"help123",password_confirmation:"help123", admin:true})
    visit '/'
    click_link 'Sign-In/Sign-Up'
    fill_in 'Email', :with => "me@me.com"
    fill_in 'Password', :with => "help123"
    click_on "Log in"
  end
  it "adds a new product" do
    visit products_path
    click_link 'Add a product'
    fill_in 'Name', :with => 'Canned olives'
    fill_in 'Cost', :with => 9.99
    fill_in 'Country of origin', :with => 'Spain'
    click_on 'Create Product'
    expect(page).to have_content 'Product added successfully!'
    expect(page).to have_content 'Canned Olives'
  end

  it "gives an error when no name is entered" do
    visit new_product_path
    fill_in 'Cost', :with => 9.99
    fill_in 'Country of origin', :with => 'Spain'
    click_on 'Create Product'
    expect(page).to have_content "Name can't be blank"
  end
  it "gives an error when no country or cost is entered" do
    visit new_product_path
    fill_in 'Name', :with => 'Vegan cheddar'
    click_on 'Create Product'
    expect(page).to have_content "Country of origin can't be blank"
    expect(page).to have_content "Cost can't be blank"
  end
  it "gives an error when non admin clicks add on index page" do
    visit '/'
    click_on "Sign Out"
    click_link 'Sign-In/Sign-Up'
    fill_in 'Email', :with => "test@me.com"
    fill_in 'Password', :with => "help123"
    click_on "Log in"
    visit '/'
    click_on 'Add a product'
    expect(page).to have_content "You are not authorized to access that feature."
  end
end
