class ChangeDefaultToOrders < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :shipping_status, :string, default: "not_shipped"
    change_column :orders, :payment_status, :string, default: "not_paid"
  end
end