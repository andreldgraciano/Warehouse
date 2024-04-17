class CreateNames < ActiveRecord::Migration[7.1]
  def change
    create_table :names do |t|
      t.string :code
      t.string :city
      t.integer :area

      t.timestamps
    end
  end
end
