class ProductModel < ApplicationRecord
  belongs_to :supplier

  validates :name, :weight, :width, :height, :depth, :sku, :supplier_id, presence: true
  validates :name, :sku, uniqueness: true
end
