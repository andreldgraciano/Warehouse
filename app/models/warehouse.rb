class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :address, :zip, :description, presence: true
  validates :code, uniqueness: true
  has_many :stock_products

  def full_description
    "#{code} - #{name}"
  end
end
