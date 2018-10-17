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
      if count.divmod(items_per_page).last != 0
        total_pages += 1
      end
      page = 1
      while page < total_pages
        new_products = ShopifyAPI::Product.all(:params => {:page => page, :limit => items_per_page})
        products += new_products
        new_products.each do |new_product|
          # rails_product = Product.create()
          # rails_product.shopify_id = new_product["id"]
          # rails_product.title = new_product["title"]
          # rails_product.shopify_created_at = new_product["created_at"]
          # rails_product.shopify_updated_at = new_product["updated_at"]
          # rails_product.shopify_published_at = new_product["published_at"]
          # rails_product.body_html = new_product["body_html"]
          # rails_product.handle = new_product["handle"]
          # rails_product.product_type = new_product["product_type"]
          # rails_product.tags = new_product["tags"]
          # rails_product.vendor = new_product["vendor"]
          # rails_product.save
          # new_product["variants"].each do |new_variant|
          #   rails_variant = rails_product.variants.create()
          #   rails_variant.shopify_id = new_variant["id"]
          #   rails_variant.shopify_product_id = new_variant["product_id"]

          # end

          new_product["shopify_id"] = new_product.delete("id")
          new_product["shopify_created_at"] = new_product.delete("created_at")
          new_product["shopify_updated_at"] = new_product.delete("updated_at")
          new_product["shopify_published_at"] = new_product.delete("published_at")
          rails_product = Product.create(new_product)
          if rails_product.save
            redirect_to root_path
          end
        end
        puts `Processing page #{page} of #{total_pages}`
        page += 1
      end
      puts `Finished - processed #{products.count} products`
    end
  end

  def save_one_to_database
    # new_product = ShopifyAPI::Product.all(:params => {:limit => 1}).first
    # puts new_product
    # new_product.delete("template_suffix")
    # new_product.delete("published_scope")
    # new_product.delete("admin_graphql_api_id")
    # new_product.delete("options")
    # new_product.delete("images")
    # new_product.delete("image")
    # new_product.delete("variants")
    # new_product["shopify_id"] = new_product.delete("id")
    # new_product["shopify_created_at"] = new_product.delete("created_at")
    # new_product["shopify_updated_at"] = new_product.delete("updated_at")
    # new_product["shopify_published_at"] = new_product.delete("published_at")
    # rails_product = Product.create(new_product)
    test_product = {
      "id": 1671288356934,
      "title": "Khaki Shorts",
      "body_html": nil,
      "vendor": "MarekECDTestStore",
      "product_type": "Bottoms",
      "created_at": "2018-10-15T23:08:38-04:00",
      "handle": "khaki-shorts",
      "updated_at": "2018-10-15T23:08:40-04:00",
      "published_at": "2018-10-15T23:08:38-04:00",
      "tags": ""
    }
    test_product["shopify_id"] = test_product.delete("id")
    test_product["shopify_created_at"] = test_product.delete("created_at")
    test_product["shopify_updated_at"] = test_product.delete("updated_at")
    test_product["shopify_published_at"] = test_product.delete("published_at")
    rails_product = Product.create(test_product)
    if rails_product.save
      redirect_to root_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:shopify_id, :title, :shopify_created_at, :shopify_updated_at, :shopify_published_at, :body_html, :handle, :product_type, :tags, :vendor)
  end

end
