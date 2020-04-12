class HomeController < ApplicationController
  def index
    @url = params[:url]
    scraped_data = Scrape::Hamrobazzar.new(@url).get_info
    product = Product.new(url: scraped_data.url, phone: scraped_data.phone, price: scraped_data.price)
    if product.save
      @product = product
      flash[:success] = "Successfully saved flash"
    else
      flash[:alert] = "Could not save product"
    end
    render 'index'
  end
end
