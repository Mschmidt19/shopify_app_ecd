class ProductsController < ApplicationController
  def create
    @product = Product.create(product_params)
    if @product.save
      redirect_to 'Home#index'
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :product_type)
  end
end
