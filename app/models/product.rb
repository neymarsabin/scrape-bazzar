class Product < ApplicationRecord

  URL_REGEX = /https:\/\/hamrobazaar\.com\/i\d+(-\w+)+\.html/

  after_save :product_updater

  validates :title, presence: true
  validates :url, presence: true,
            format: { with: URL_REGEX, message: "Only allow specific urls" },
            uniqueness: true
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
    UpdateProductJob.set(wait: 1.week).perform_later(self.id)
  end
end
