class ProductsController < ApplicationController
  include Devise::Controllers::Helpers 
  skip_before_action :authenticate_user!, :only => [:index, :show]
  before_action :only => [:edit,:destroy] do
    if !current_user.admin
      flash[:alert] = "You are not authorized to access that feature."
    end
    redirect_to root_path unless current_user.admin
  end
  def index
    @products = Product.all
    render :index
  end

  def new 
    @product = Product.new
    render :new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Product added successfully!"
      redirect_to products_path
    else

      flash[:alert] = "There was an error in creating your product."
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    render :edit
  end

  def show
    @product = Product.find(params[:id])
    render :show
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "product update success!"
      redirect_to products_path
    else
      flash[:alert] = "There was an error in updating your product."
      render :edit
    end
  end
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Product deleted successfully."
    redirect_to products_path
  end

  private
    def product_params
      params.require(:product).permit(:name, :cost, :country_of_origin)
    end
end