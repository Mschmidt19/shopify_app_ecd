class ChangeIntegerLimitInVariants < ActiveRecord::Migration[5.2]
  def change
    change_column :variants, :shopify_id :integer, limit: 8
    change_column :variants, :shopify_product_id :integer, limit: 8
  end
end
