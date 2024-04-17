class AddNameToWarehouse < ActiveRecord::Migration[7.1]
  def change
    add_column :warehouses, :name, :string
  end
end
