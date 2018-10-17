class CreateVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :variants do |t|
      t.integer "shopify_id", null: false
      t.integer "shopify_product_id"
      t.string "title"
      t.string "shopify_created_at"
      t.string "shopify_updated_at"
      t.string "price"
      t.string "sku"
      t.string "option1"
      t.string "option2"
      t.string "option3"
      t.integer "position"
      t.boolean "taxable"
      t.float "weight"
      t.string "weight_unit"
      t.integer "inventory_quantity"
      t.references :product
      t.timestamps
    end
  end
end
