class Product < ApplicationRecord

  validates :title, presence: true
  validates :url, presence: true
  validates :description, presence: true
  validates :price, presence: true


  def self.find_or_scrape(url)
    product = find_by(url: url)
    return product if product

    scrape_object = Scrape::Hamrobazzar.new(url)
    scrape_object.get_info

    product = create(
      url: scrape_object.url,
      title: scrape_object.title,
      description: scrape_object.description,
      price: scrape_object.price,
      mobile_number: scrape_object.phone
    )
    return product
  end
end
