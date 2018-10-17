class ChangeIntegerLimitInProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :shopify_id, :integer, limit: 8
  end
end
