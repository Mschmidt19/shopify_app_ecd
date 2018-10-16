class ProductsController < ShopifyApp::AuthenticatedController

  def new
    @product = ShopifyAPI::Product.new
    @product.title = params[:title]
    @product.product_type = params[:product_type]
    # sizes = params[:sizes].split(/\s*,\s*/)
    # colors = params[:colors].split(/\s*,\s*/)
    # @product.options = [
    #   {
    #     "name": "Size",
    #     "values": sizes
    #   },
    #   {
    #     "name": "Color",
    #     "values": colors
    #   }
    # ]
    @product.variants = [{"option1": "Blue", "option2": "155"}, {"option1": "Black", "option2": "159"}]
    @product.options = [{"name": "Color", "values": ["Blue", "Black"]}, {"name": "Size", "values": ["155", "159"]}]
    if @product.save
      redirect_to root_path
    end
  end

  def generateall

  end

  def deleteall
    ShopifyAPI::Product.find(10).destroy
    redirect_to root_path
  end

end
