class ProductsController < ShopifyApp::AuthenticatedController

  def new
    @product = ShopifyAPI::Product.new
    @product.title = params[:title]
    @product.product_type = params[:product_type]
    if @product.save
      redirect_to root_path
    end
  end

  def generateall

  end

  def deleteall
    @products = ShopifyAPI::product.find(:all)
    @products.each do |product|
      product.destroy
    end
    redirect_to root_path1
  end

end
