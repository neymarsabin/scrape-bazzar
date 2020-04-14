class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
    product = Product.find_or_save(product_params[:url])
    render json: { data: product }
  rescue => e
    render json: { error: "Error while scraping URL!!" }, status: 400
  end

  private

  def product_params
    params.permit(:url)
  end
end
