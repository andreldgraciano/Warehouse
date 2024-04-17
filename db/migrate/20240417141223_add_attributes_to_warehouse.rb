class AddAttributesToWarehouse < ActiveRecord::Migration[7.1]
  def change
    add_column :warehouses, :address, :string
    add_column :warehouses, :zip, :integer
    add_column :warehouses, :description, :string
  end
end
