module Shopify
  require 'uri'
  require 'net/http'

  def self.products
    url = URI("https://marekecdteststore.myshopify.com/admin/products.json")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["Postman-Token"] = '92b03b7b-8a7c-4794-afe3-166eb5bead2c'

    response = http.request(request)
    puts response.read_body

    return response.read_body
  end

end
