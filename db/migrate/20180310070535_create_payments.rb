class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :order_id, null: false
      t.integer :sn, null:false
      t.integer :amount, null:false
      t.string :payment_method
      t.datetime :paid_at
      t.text :params

      t.timestamps
    end
  end
end
