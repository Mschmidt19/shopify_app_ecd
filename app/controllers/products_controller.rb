class ProductsController < ShopifyApp::AuthenticatedController
  include Shopify

  def new
    if Shopify.new_product
      redirect_to root_path
    end
  end

  def create
    @product = Product.create(product_params)
    @product.save
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:shopify_id, :title, :shopify_created_at, :shopify_updated_at, :shopify_published_at, :body_html, :handle, :product_type, :tags, :vendor)
  end

  def save_to_database
    Shopify.save_to_database
    redirect_to root_path
  end

end
