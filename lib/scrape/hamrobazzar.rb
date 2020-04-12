require 'open-uri'
require 'mechanize'

module Scrape
  class Hamrobazzar

    def initialize(url)
      @url = url
    end

    def get_data
      table_data = page.search("#white")
      title = page.search(".title").first.content.strip
      td_mobile = table_data.at("td:contains('Mobile Phone')")
      td_price = table_data.at("td:contains('Price')")
      description_node = page.search("tr").at("b:contains('Description')")

      {
        title: title,
        description: process_description(description_node),
        phone: process_mobile(td_mobile.parent),
        price: process_price(td_price.parent),
        url: @url
      }
    end

    private

    def page
      Mechanize.new.get(@url)
    end

    def process_mobile(mobile_node)
      mobile_node&.content&.strip&.split(":")[1]&.split(" ")[0]
    end

    def process_price(price_node)
      price_node&.content.strip.split(" ")[1]
    end

    def process_description(description_node)
      description_node.ancestors[6]&.content&.split("Description")[1]&.strip&.gsub("\r\n", " ")
    end
  end
end
