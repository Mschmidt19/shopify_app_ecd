class ProductsController < ApplicationController
  around_filter :shopify_session
  layout 'embedded_app'
  def new
    @product = ShopifyAPI::Product.new
    @product.title = params[:title]
    @product.product_type = params[:product_type]
    if @product.save
      redirect_to root_path
    end
  end

  # private
  #
  # def product_params
  #   params.require(:product).permit(:title, :product_type)
  # end
end
