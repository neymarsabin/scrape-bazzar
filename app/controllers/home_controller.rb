class HomeController < ApplicationController
  def index
    @url = params[:url]
    if @url
      scraped_data = Scrape::Hamrobazzar.new(@url)
      scraped_data.get_info
      product = Product.new(
        url: scraped_data.url,
        title: scraped_data.title,
        mobile_number: scraped_data.phone,
        price: scraped_data.price,
        description: scraped_data.description
      )
      if product.save
        @product = product
        flash[:success] = "Successfully saved flash"
      else
        flash[:alert] = "Could not save product"
      end
      render 'index'
    end
  end
end
