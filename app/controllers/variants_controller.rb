class VariantsController < ApplicationController
  def create
    @product = Product.find()
    @comment = @product.variants.create(comment_params)
    @comment.save
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:variant).permit(:shopify_id, :shopify_product_id, :title, :shopify_created_at, :shopify_updated_at, :shopify_published_at, :price, :sku, :option1, :option2, :option3, :position, :taxable, :weight, :weight_unit, :inventory_quantity)
  end
end
