class HomeController < ShopifyApp::AuthenticatedController
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 20 })
    @webhooks = ShopifyAPI::Webhook.find(:all)
    p "Made it to home page"
  end
end
