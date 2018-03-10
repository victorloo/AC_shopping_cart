class ChangeOrderIdToPayments < ActiveRecord::Migration[5.1]
  def change
    change_column :payments, :order_id, :integer, index: true
  end
end
