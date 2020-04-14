class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def show
  end

  def create
    url = product_params[:url]
    @product = Product.find_or_scrape(url)
    render json: { data: @product }
  end

  private

  def product_params
    params.permit(:url)
  end
end
