require 'rails_helper'

describe "the edit a product process" do
  it "edits a product" do
    visit products_path
    click_link 'Add a product'
    fill_in 'Name', :with => 'Canned olives'
    fill_in 'Cost', :with => 9.99
    fill_in 'Country of origin', :with => 'Spain'
    click_on 'Create Product'
    click_link 'Canned Olives'
    click_link 'Edit'
    fill_in 'Name', :with => 'gingerbread cookie'
    fill_in 'Cost', :with => 2.99
    fill_in 'Country of origin', :with => 'Germany'
    click_on 'Update Product'
    expect(page).to have_content 'Gingerbread Cookie'
    expect(page).to have_no_content 'Canned Olives'
  end
end