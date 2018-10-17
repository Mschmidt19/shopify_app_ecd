class HomeController < ShopifyApp::AuthenticatedController
  include Shopify

  def index
    @products = ShopifyAPI::Product.find(:all)
    @products_from_rails = Product.all
    @variants_from_rails = Variant.all
  end


end
