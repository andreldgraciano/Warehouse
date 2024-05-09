class ChangeEstimatedDeliveryDateToOrder < ActiveRecord::Migration[7.1]
  def change
    change_column_null :orders, :estimated_delivery_date, false
  end
end
