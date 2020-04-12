class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    url = product_params[:url]
    @product = Product.find_or_scrape(url)
    redirect_to(@product)
  end

  private

  def product_params
    params.permit(:url)
  end
end
