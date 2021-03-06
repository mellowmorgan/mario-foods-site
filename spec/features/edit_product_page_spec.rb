require 'rails_helper'

describe "the edit a product process" do
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
  it "edits a product" do
  
    click_link 'Canned Olives'
    click_link 'Edit'
    fill_in 'Name', :with => 'gingerbread cookie'
    fill_in 'Cost', :with => 2.99
    fill_in 'Country of origin', :with => 'Germany'
    click_on 'Update Product'
    expect(page).to have_content 'Gingerbread Cookie'
    expect(page).to have_no_content 'Canned Olives'
  end
  it "shows error message product not updated" do
    click_link 'Canned Olives'
    click_link 'Edit'
    fill_in 'Name', :with => nil
    fill_in 'Cost', :with => 2.99
    fill_in 'Country of origin', :with => 'Germany'
    click_on 'Update Product'
    expect(page).to have_content "There was an error in updating your product."
  end
  it "show message and doesn't allow if not admin" do
    click_on "Sign Out"
    click_link 'Sign-In/Sign-Up'
    fill_in 'Email', :with => "test@me.com"
    fill_in 'Password', :with => "help123"
    click_on "Log in"
    visit products_path
    click_on 'Canned Olives'
    click_on 'Edit'
    expect(page).to have_content "You are not authorized to access that feature."
  end
end