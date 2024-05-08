class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  validates :code, :estimated_delivery_date, presence: true

  #para ser valido
  validate :estimated_delivery_date_is_future

  #antes de conferir a validação
  before_validation :generate_code

  private

  def generate_code
    if !self.code
      self.code = SecureRandom.alphanumeric(10)
    end
  end

  def estimated_delivery_date_is_future
    if self.estimated_delivery_date.present? && self.estimated_delivery_date <= Date.today
      self.errors.add(:estimated_delivery_date, ' deve ser maior que hoje')
    end
  end
end
