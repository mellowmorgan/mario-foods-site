require 'rails_helper'

describe "the delete a product process" do
  it "deletes a product" do
    visit products_path
    click_link 'Add a product'
    fill_in 'Name', :with => 'Canned olives'
    fill_in 'Cost', :with => 9.99
    fill_in 'Country of origin', :with => 'Spain'
    click_on 'Create Product'
    click_on 'Canned Olives'
    click_on 'Delete Product'
    
    expect(page).to have_no_content 'Canned Olives'
  end

end