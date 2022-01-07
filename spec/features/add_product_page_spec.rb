require 'rails_helper'

describe "the add a project process" do
  it "adds a new project" do
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
end
