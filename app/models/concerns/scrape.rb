require 'open-uri'
require 'nokogiri'
require 'mechanize'

module Scrape
  extend ActiveSupport::Concern
  class Hamrobazzar

    attr_accessor :url, :phone, :price, :description

    def initialize(url)
      @url = url
      @phone = nil
      @price = nil
      @description = nil
    end

    def get_info
      agent = Mechanize.new
      page = agent.get(@url)
      title = page.search("#white")
      title.each do |el|
        text = el.parent&.content
        name = text.split(":")[0]&.strip
        value = text.split(":")[1]&.strip
        next if !matchers.include?(name)
        @phone = value if name == "Mobile Phone"
        @price = value if name == "Price"
      end
    end
  end
end
