module Shopify
  require 'uri'
  require 'net/http'
  require 'net/https'

  def self.products
    url = URI("https://marekecdteststore.myshopify.com/admin/products.json")

    http = Net::HTTP.new(url.host, 443)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request.basic_auth ENV["SHOPIFY_API_KEY"], ENV["SHOPIFY_API_PASSWORD"]
    request["cache-control"] = 'no-cache'
    request["Postman-Token"] = '92b03b7b-8a7c-4794-afe3-166eb5bead2c'

    response = http.request(request)

    return response.read_body
  end

  # def self.new_product
  #   product = ShopifyAPI::Product.new
  #   product.title = params[:title]
  #   product.product_type = params[:product_type]
  #   sizes = params[:sizes].split(/\s*,\s*/)
  #   colors = params[:colors].split(/\s*,\s*/)
  #   variants = []
  #   sizes.each do |size|
  #     colors.each do |color|
  #       variant = {}
  #       variant["option1"] = size
  #       variant["option2"] = color
  #       variant["price"] = params[:price]
  #       variants.push(variant)
  #     end
  #   end
  #   product.variants = variants
  #   product.options = [
  #     {
  #       "name": "Size",
  #       "values": sizes
  #     },
  #     {
  #       "name": "Color",
  #       "values": colors
  #     }
  #   ]
  #   if product.save
  #     return true
  #   end
  # end
  #
  # def self.save_to_database
  #   items_per_page = 5
  #   products = []
  #   count = ShopifyAPI::Product.count
  #   if count > 0
  #     total_pages = count.divmod(items_per_page).first
  #     if count.divmod(items_per_page).last != 0
  #       total_pages += 1
  #     end
  #     page = 1
  #     while page < total_pages
  #       new_products = ShopifyAPI::Product.all(:params => {:page => page, :limit => items_per_page})
  #       products += new_products
  #       new_products.each do |new_product|
  #         rails_product = Product.create()
  #         rails_product.shopify_id = new_product["id"]
  #         rails_product.title = new_product["title"]
  #         # rails_product.shopify_created_at = new_product["created_at"]
  #         # rails_product.shopify_updated_at = new_product["updated_at"]
  #         # rails_product.shopify_published_at = new_product["published_at"]
  #         # rails_product.body_html = new_product["body_html"]
  #         # rails_product.handle = new_product["handle"]
  #         # rails_product.product_type = new_product["product_type"]
  #         # rails_product.tags = new_product["tags"]
  #         # rails_product.vendor = new_product["vendor"]
  #         # rails_product.save
  #         # new_product["variants"].each do |new_variant|
  #         #   rails_variant = rails_product.variants.create()
  #         #   rails_variant.shopify_id = new_variant["id"]
  #         #   rails_variant.shopify_product_id = new_variant["product_id"]
  #
  #         # end
  #         rails_product.save
  #       end
  #       puts `Processing page #{page} of #{total_pages}`
  #       page += 1
  #     end
  #   end
  #   puts `Finished - processed #{products.count} products`
  # end

end
