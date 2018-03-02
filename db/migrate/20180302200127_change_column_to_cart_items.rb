class ChangeColumnToCartItems < ActiveRecord::Migration[5.1]
  def change
    change_column :cart_items, :cart_id, :integer, null: false
  end
end
