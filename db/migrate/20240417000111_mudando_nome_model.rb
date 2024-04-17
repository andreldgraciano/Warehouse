class MudandoNomeModel < ActiveRecord::Migration[7.1]
  def change
    rename_table :names, :warehouses
  end
end
