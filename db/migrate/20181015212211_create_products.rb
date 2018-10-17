class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer "shopify_id", null: false
      t.string "title", null: false
      t.string "shopify_created_at"
      t.string "shopify_updated_at"
      t.string "shopify_published_at"
      t.text "body_html"
      t.string "handle"
      t.string "product_type"
      t.text "tags"
      t.string "vendor"
      t.timestamps
    end
  end
end
