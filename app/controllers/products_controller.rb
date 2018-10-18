class ProductsController < ShopifyApp::AuthenticatedController

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

  def destroy_all_from_database
    Product.destroy_all
    redirect_to root_path
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
        new_products = next_five_products(page, items_per_page)
        new_products.each do |new_product|
          rails_product = create_or_find_product(new_product)
          variant_hash_array = create_new_variants_array(new_product)
          rails_product.variants.create(variant_hash_array) unless variant_hash_array.empty?
        end
        page += 1
      end
      redirect_to root_path
    end
  end

  private

  def next_five_products(page, limit)
    five_products = ShopifyAPI::Product.all(:params => {:page => page, :limit => limit})
  end

  def create_or_find_product(product)
    if !Product.exists?(shopify_id: product.id)
      hash = {
        "shopify_id": product.id,
        "title": product.title,
        "body_html": product.body_html,
        "vendor": product.vendor,
        "product_type": product.product_type,
        "shopify_created_at": product.created_at,
        "handle": product.handle,
        "shopify_updated_at": product.updated_at,
        "shopify_published_at": product.published_at,
        "tags": product.tags
      }
      rails_product = Product.create(hash)
    else
      rails_product = Product.where(shopify_id: product.id).first
    end
    return rails_product
  end

  def create_new_variants_array(product)
    variant_hash_array = []
    product.variants.each do |variant|
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
    return variant_hash_array
  end

  def product_params
    params.require(:product).permit(:shopify_id, :title, :shopify_created_at, :shopify_updated_at, :shopify_published_at, :body_html, :handle, :product_type, :tags, :vendor)
  end

end
