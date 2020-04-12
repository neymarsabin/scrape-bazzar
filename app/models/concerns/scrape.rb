require 'open-uri'
require 'nokogiri'
require 'mechanize'

module Scrape
  extend ActiveSupport::Concern
  class Hamrobazzar
    MATCHERS = [
      "Price",
      "Mobile Phone"
    ].freeze

    attr_accessor :url, :phone, :price, :description, :title

    def initialize(url)
      @url = url
    end

    def get_info
      table_data = page.search("#white")
      table_data.each do |el|
        text = el.parent&.content
        name = text.split(":")[0]&.strip
        value = text.split(":")[1]&.strip
        next if !MATCHERS.include?(name)
        @phone = value if name == "Mobile Phone"
        @price = value if name == "Price"
      end

      # for title and description
      @title = page.search(".title")[0].content.strip
      description_text = page.search("b").select { |e| e.content.strip == "Description" }
      @description = description_text.first.parent.parent.parent.parent.parent.parent.parent.children[1].content.strip
    end

    private

    def page
      agent = Mechanize.new
      page = agent.get(@url)
    end
  end
end
