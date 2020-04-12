class Product < ApplicationRecord

  after_save :product_updater

  validates :title, presence: true
  validates :url, presence: true
  validates :description, presence: true
  validates :price, presence: true


  def self.find_or_scrape(url)
    product = find_by(url: url)
    return product if product

    scrape_object = scrape(url)

    product = create(
      url: scrape_object.url,
      title: scrape_object.title,
      description: scrape_object.description,
      price: scrape_object.price,
      mobile_number: scrape_object.phone
    )
    return product
  end

  def self.scrape(url)
    scrape_object = Scrape::Hamrobazzar.new(url)
    scrape_object.get_info
    scrape_object
  end

  private

  def product_updater
    UpdateProductWorker.perform_at(1.weeks.from_now, self.id)
  end
end
