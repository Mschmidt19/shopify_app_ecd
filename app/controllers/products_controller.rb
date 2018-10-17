class ProductsController < ShopifyApp::AuthenticatedController
  include Shopify

  def new
    product = ShopifyAPI::Product.new
    product.title = params[:title]
    product.product_type = params[:product_type]
    sizes = params[:sizes].split(/\s*,\s*/)
    colors = params[:colors].split(/\s*,\s*/)
    variants = []
    sizes.each do |size|
      colors.each do |color|
        variant = {}
        variant["option1"] = size
        variant["option2"] = color
        variant["price"] = params[:price]
        variants.push(variant)
      end
    end
    product.variants = variants
    product.options = [
      {
        "name": "Size",
        "values": sizes
      },
      {
        "name": "Color",
        "values": colors
      }
    ]
    if product.save
      redirect_to root_path
    end
  end

  def create
    Product.create(product_params)
  end

  def save_to_database
    items_per_page = 5
    products = []
    count = ShopifyAPI::Product.count
    if count > 0
      total_pages = count.divmod(items_per_page).first
      if count.divmod(items_per_page).last != 0 && count > items_per_page
        total_pages += 1
      end
      page = 1
      while page <= total_pages
        new_products = ShopifyAPI::Product.all(:params => {:page => page, :limit => items_per_page})
        new_products.each do |new_product|
          if !Product.exists?(shopify_id: new_product.id)
            hash = {
              "shopify_id": new_product.id,
              "title": new_product.title,
              "body_html": new_product.body_html,
              "vendor": new_product.vendor,
              "product_type": new_product.product_type,
              "shopify_created_at": new_product.created_at,
              "handle": new_product.handle,
              "shopify_updated_at": new_product.updated_at,
              "shopify_published_at": new_product.published_at,
              "tags": new_product.tags
            }
            rails_product = Product.create(hash)
          else
            rails_product = Product.where(shopify_id: new_product.id).first
          end
          variant_hash_array = []
          new_product.variants.each do |variant|
            if !Variant.exists?(shopify_product_id: new_product.id, shopify_id: variant.id)
              variant_hash = {
                "shopify_id": variant.id,
                "shopify_product_id": variant.product_id,
                "title": variant.title,
                "shopify_created_at": variant.created_at,
                "shopify_updated_at": variant.updated_at,
                "price": variant.price,
                "sku": variant.sku,
                "option1": variant.option1,
                "option2": variant.option2,
                "option3": variant.option3,
                "position": variant.position,
                "taxable": variant.taxable,
                "weight": variant.weight,
                "weight_unit": variant.weight_unit,
                "inventory_quantity": variant.inventory_quantity
              }
              variant_hash_array.push(variant_hash)
            end
          end
          rails_product.variants.create(variant_hash_array) unless variant_hash_array.empty?
        end
        puts `Processing page #{page} of #{total_pages}`
        page += 1
      end
      puts `Finished - processed #{products.count} products`
      redirect_to root_path
    end
  end

  def delete_all_from_database
    Product.destroy_all
  end

  # def save_one_to_database
  #   new_product = ShopifyAPI::Product.all(:params => {:limit => 1}).first
  #   hash = {
  #     "shopify_id": new_product.id,
  #     "title": new_product.title,
  #     "body_html": new_product.body_html,
  #     "vendor": new_product.vendor,
  #     "product_type": new_product.product_type,
  #     "shopify_created_at": new_product.created_at,
  #     "handle": new_product.handle,
  #     "shopify_updated_at": new_product.updated_at,
  #     "shopify_published_at": new_product.published_at,
  #     "tags": new_product.tags
  #   }
  #
  #   variant_hash_array = []
  #   new_product.variants.each do |variant|
  #     variant_hash = {
  #       "shopify_id": variant.id,
  #       "shopify_product_id": variant.product_id,
  #       "title": variant.title,
  #       "shopify_created_at": variant.created_at,
  #       "shopify_updated_at": variant.updated_at,
  #       "price": variant.price,
  #       "sku": variant.sku,
  #       "option1": variant.option1,
  #       "option2": variant.option2,
  #       "option3": variant.option3,
  #       "position": variant.position,
  #       "taxable": variant.taxable,
  #       "weight": variant.weight,
  #       "weight_unit": variant.weight_unit,
  #       "inventory_quantity": variant.inventory_quantity
  #     }
  #     variant_hash_array.push(variant_hash)
  #   end
  #
  #   rails_product = Product.create(hash)
  #   rails_product.variants.create(variant_hash_array)
  #   redirect_to root_path
  # end
  #
  # def save_five_to_database
  #   products = ShopifyAPI::Product.all(:params => {:page => 2, :limit => 5})
  #   hashes = []
  #   products.each do |new_product|
  #     hash = {
  #       "shopify_id": new_product.id,
  #       "title": new_product.title,
  #       "body_html": new_product.body_html,
  #       "vendor": new_product.vendor,
  #       "product_type": new_product.product_type,
  #       "shopify_created_at": new_product.created_at,
  #       "handle": new_product.handle,
  #       "shopify_updated_at": new_product.updated_at,
  #       "shopify_published_at": new_product.published_at,
  #       "tags": new_product.tags
  #     }
  #     hashes.push(hash)
  #   end
  #   rails_product = Product.create(hashes)
  #   redirect_to root_path
  # end

  private

  def product_params
    params.require(:product).permit(:shopify_id, :title, :shopify_created_at, :shopify_updated_at, :shopify_published_at, :body_html, :handle, :product_type, :tags, :vendor)
  end

end
