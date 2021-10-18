class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.string :zip_code

      t.timestamps
    end
    add_index :customers, :name
  end
end
