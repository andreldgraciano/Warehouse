class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
  has_many :order_items
  has_many :product_models, through: :order_items

  enum status: { pending: 0, delivered: 5, canceled: 9 }

  validates :code, :estimated_delivery_date, presence: true

  #para ser valido
  validate :estimated_delivery_date_is_future

  #antes de conferir a validação
  before_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10)
  end

  def estimated_delivery_date_is_future
    if self.estimated_delivery_date != nil && self.estimated_delivery_date <= Date.today
      self.errors.add(:estimated_delivery_date, ' deve ser maior que hoje')
    end
  end
end
