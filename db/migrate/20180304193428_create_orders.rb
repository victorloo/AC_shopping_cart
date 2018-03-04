class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.integer :sn, null: false
      t.integer :amount, null: false
      t.string :shipping_status, default: "non-shipping"
      t.string :name, null: false
      t.string :phone, null: false
      t.string :payment_status, default: "non-payment"
      t.string :address, null: false

      t.timestamps
    end
  end
end
