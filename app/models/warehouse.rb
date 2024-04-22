class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :address, :zip, :description, presence: true
  validates :code, uniqueness: true

  def full_description
    "#{code} - #{name}"
  end
end
