ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = "219f2f077c7aa5cf34ab47ce17c9372d"
  config.secret = "a9b4d8fe847797bf12ea5347bef10d26"
  config.scope = "read_orders, read_products, write_products"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = Shop
end
