class ReviewsController < ApplicationController
  include Devise::Controllers::Helpers 

  def new
    @product = Product.find(params[:product_id]) 
    @review = @product.reviews.new
    render :new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    if @review.save
      flash[:notice] = "Review added successfully!"
      redirect_to product_path(@product)
    else

      flash[:alert] = "There was an error in creating your review."
      render :new
    end
  end

  def edit
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    render :edit
  end

  def show
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    render :show
  end

  def update
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "Review updated successfully!"
      redirect_to product_review_path
    else
      flash[:alert] = "There was an error in updating your review."
      render :edit
    end
  end
  def destroy
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "Review deleted successfully."
    redirect_to product_path(@product)
  end

  private
    def review_params
      params.require(:review).permit(:author, :rating, :content_body)
    end
end