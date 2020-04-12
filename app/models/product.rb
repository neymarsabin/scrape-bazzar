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

    create(
      url: scrape_object[:url],
      title: scrape_object[:title],
      description: scrape_object[:description],
      price: scrape_object[:price],
      mobile_number: scrape_object[:phone]
    )
  end

  def self.scrape(url)
    Scrape::Hamrobazzar.new(url).get_data
  end

  private

  def product_updater
    UpdateProductWorker.perform_at(1.weeks.from_now, self.id)
  end
end
