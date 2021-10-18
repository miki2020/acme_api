class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :payment_token, :null => false
      t.references :customer, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
