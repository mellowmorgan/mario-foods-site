class SearchesController < ApplicationController
  include Devise::Controllers::Helpers 
  skip_before_action :authenticate_user!

  def index
    s = params[:search]
    @results = Product.search_products(s)
    render :index
  end
end
