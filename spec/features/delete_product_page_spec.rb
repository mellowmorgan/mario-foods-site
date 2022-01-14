require 'rails_helper'

describe "the delete a product process" do
  before(:each) do
    @user2 = User.create!({email:"test@me.com", password:"help123",password_confirmation:"help123", admin:false})
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
  end
  it "deletes a product" do
    visit '/'
    click_on 'Canned Olives'
    click_on 'Delete product'
    expect(page).to have_content 'Product deleted successfully.'
  end
  
  it "show message and doesn't allow if not admin" do
    click_on "Sign Out"
    click_link 'Sign-In/Sign-Up'
    fill_in 'Email', :with => "test@me.com"
    fill_in 'Password', :with => "help123"
    click_on "Log in"
    visit products_path
    click_on 'Canned Olives'
    click_on 'Delete product'
    expect(page).to have_content "You are not authorized to access that feature."
  end
  it "show message and doesn't allow if not user" do
    click_on "Sign Out"
    visit products_path
    click_on 'Canned Olives'
    click_on 'Delete product'
    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
end