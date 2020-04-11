class Product < ApplicationRecord

  validates :title, presence: true
  validates :url, presence: true
  validates :description, presence: true
  validates :price, presence: true

end
