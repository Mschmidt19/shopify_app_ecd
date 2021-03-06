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

end
