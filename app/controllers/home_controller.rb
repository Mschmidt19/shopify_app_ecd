class HomeController < ShopifyApp::AuthenticatedController
  include Shopify

  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 20 })
    @webhooks = ShopifyAPI::Webhook.find(:all)
    @shopify = Shopify 
  end


end
