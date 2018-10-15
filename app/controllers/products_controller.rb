require 'httparty'

class ProductsController < ShopifyApp::AuthenticatedController

  def new
    @product = ShopifyAPI::Product.new
    p params
    @product.title = params[:title]
    @product.product_type = params[:product_type]
    if @product.save
      redirect_to root_path
    end
  end

  def new2
    @body = {
      "product": {
        "title": "Burton Custom Freestyle 151",
        "body_html": "<strong>Good snowboard!</strong>",
        "vendor": "Burton",
        "product_type": "Snowboard",
        "variants": [
          {
            "option1": "Blue",
            "option2": "155"
          },
          {
            "option1": "Black",
            "option2": "159"
          }
        ],
        "options": [
          {
            "name": "Color",
            "values": [
              "Blue",
              "Black"
            ]
          },
          {
            "name": "Size",
            "values": [
              "155",
              "159"
            ]
          }
        ]
      }
    }
    response = HTTParty.post(
      `https://#{@shop_session.url}/admin/products.json`,
      :body => @body.to_json,
      :headers => {'Content-Type' => 'application/json'}
    )
    p response


  end

  # private
  #
  # def product_params
  #   params.require(:product).permit(:title, :product_type)
  # end
end
