class HomeController < ShopifyApp::AuthenticatedController
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 99 })
    @webhooks = ShopifyAPI::Webhook.find(:all)
  end
end
