class HomeController < ShopifyApp::AuthenticatedController
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 20 })
    @webhooks = ShopifyAPI::Webhook.find(:all)
    @product = ShopifyAPI::Product.new
  end
end
