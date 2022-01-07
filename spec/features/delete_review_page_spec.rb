require 'rails_helper'

describe "the delete a review process" do
  before(:each) do
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
  it "deletes a review" do
    visit products_path
    click_on 'Canned Olives'
    click_on 'Review by Morgan'
    click_on 'Delete review'
    expect(page).to have_no_content 'Morgan'
    expect(page).to have_content 'Review deleted successfully.'
  end
end
