require 'rails_helper'

describe "the add a review process" do
  before(:each) do
    visit products_path
    click_link 'Add a product'
    fill_in 'Name', :with => 'Canned olives'
    fill_in 'Cost', :with => 9.99
    fill_in 'Country of origin', :with => 'Spain'
    click_on 'Create Product'
  end
  it "adds a new review" do
    visit products_path
    click_on 'Canned Olives'
    click_on 'Add a review'
    fill_in 'Author', :with => 'Morgan'
    fill_in 'Rating', :with => 4
    fill_in 'Content body', :with => 'It was awful terrible disgusting I hated it this item should not be sold it should be removed from all stores oh the horror of these disgusting olives never again will I buy them'
    click_on 'Create Review'
    expect(page).to have_content 'Review added successfully!'
    expect(page).to have_content 'oh the horror'
  end

  it "gives an error when no author is entered" do
    visit new_product_path
    visit products_path
    click_on 'Canned Olives'
    click_on 'Add a review'
    fill_in 'Rating', :with => 4
    fill_in 'Content body', :with => 'It was awful terrible disgusting I hated it this item should not be sold it should be removed from all stores oh the horror of these disgusting olives never again will I buy them'
    click_on 'Create Review'
    expect(page).to have_content "There was an error in creating your review."
    expect(page).to have_content "Author can't be blank"
  end
  it "gives an error when no content or rating is entered" do
    visit new_product_path
    visit products_path
    click_on 'Canned Olives'
    click_on 'Add a review'
    fill_in 'Author', :with => 'Morgan'
    click_on 'Create Review'
    expect(page).to have_content "There was an error in creating your review."
    expect(page).to have_content "Rating can't be blank"
    expect(page).to have_content "Content body can't be blank"
  end
  it "gives an error when rating is out of range content body length out of range" do
    visit new_product_path
    visit products_path
    click_on 'Canned Olives'
    click_on 'Add a review'
    fill_in 'Author', :with => 'Morgan'
    fill_in 'Rating', :with => 10
    fill_in 'Content body', :with => 'It was awful terrible disgusting I hated it.'
    click_on 'Create Review'
    expect(page).to have_content "There was an error in creating your review."
    expect(page).to have_content "Rating is not included in the list"
    expect(page).to have_content "Content body is too short (minimum is 50 characters)"
  end
end
