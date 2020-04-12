class UpdateProductWorker
  include Sidekiq::Worker
  queue: 'update_products', retry: 2

  def perform(id)
    product = Product.find(id)
    url = product.url
    scrape_object = Product.scrape(url)
    product.update(
      title: scrape_object.title,
      description: scrape_object.description,
      price: scrape_object.price,
      mobile_number: scrape_object.phone
    )
  end
end
