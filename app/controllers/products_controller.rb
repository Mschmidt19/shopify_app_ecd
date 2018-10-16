require "httparty"
require "net/http"
require "uri"

class ProductsController < ShopifyApp::AuthenticatedController
  include HTTParty

  def new
    product = ShopifyAPI::Product.new
    product.title = params[:title]
    product.product_type = params[:product_type]
    sizes = params[:sizes].split(/\s*,\s*/)
    colors = params[:colors].split(/\s*,\s*/)
    variants = []
    sizes.each do |size|
      colors.each do |color|
        variant = {}
        variant["option1"] = size
        variant["option2"] = color
        variant["price"] = params[:price]
        variants.push(variant)
      end
    end
    product.variants = variants
    product.options = [
      {
        "name": "Size",
        "values": sizes
      },
      {
        "name": "Color",
        "values": colors
      }
    ]
    if product.save
      redirect_to root_path
    end
  end

  def generateall
    products = [
      {"title": "Short Sleeve Crewneck",
        "product_type": "Tops",
        "sizes": "S, M, L",
        "colors": "White, Black, Gray, Blue",
        "price": "15.00"
      },
      {"title": "Short Sleeve V-Neck",
        "product_type": "Tops",
        "sizes": "S, M, L",
        "colors": "White, Black, Gray, Blue",
        "price": "15.00"
      },
      {"title": "Short Sleeve Henley",
        "product_type": "Tops",
        "sizes": "S, M, L",
        "colors": "White, Black, Gray, Blue",
        "price": "15.00"
      },
      {"title": "Long Sleeve Crewneck",
        "product_type": "Tops",
        "sizes": "S, M, L",
        "colors": "White, Black, Gray, Blue",
        "price": "20.00"
      },
      {"title": "Long Sleeve V-Neck",
        "product_type": "Tops",
        "sizes": "S, M, L",
        "colors": "White, Black, Gray, Blue",
        "price": "20.00"
      },
      {"title": "Long Sleeve Henley",
        "product_type": "Tops",
        "sizes": "S, M, L",
        "colors": "White, Black, Gray, Blue",
        "price": "20.00"
      },
      {"title": "Khaki Shorts",
        "product_type": "Bottoms",
        "sizes": "30, 32, 34, 36, 38, 40",
        "colors": "Blue, Black, Brown",
        "price": "20.00"
      },
      {"title": "Denim Shorts",
        "product_type": "Bottoms",
        "sizes": "30, 32, 34, 36, 38, 40",
        "colors": "Blue, Black, Brown",
        "price": "20.00"
      },
      {"title": "Khaki Pants",
        "product_type": "Bottoms",
        "sizes": "30, 32, 34, 36, 38, 40",
        "colors": "Blue, Black, Brown",
        "price": "30.00"
      },
      {"title": "Denim Pants",
        "product_type": "Bottoms",
        "sizes": "30, 32, 34, 36, 38, 40",
        "colors": "Blue, Black, Brown",
        "price": "30.00"
      }
    ]
    products.each do |product|
      new_product = ShopifyAPI::Product.new
      new_product.title = product["title"]
      new_product.product_type = product["product_type"]
      sizes = products["sizes"].split(/\s*,\s*/)
      colors = products["colors"].split(/\s*,\s*/)
      variants = []
      sizes.each do |size|
        colors.each do |color|
          variant = {}
          variant["option1"] = size
          variant["option2"] = color
          variant["price"] = params[:price]
          variants.push(variant)
        end
      end
      new_product.variants = variants
      new_product.options = [
        {
          "name": "Size",
          "values": sizes
        },
        {
          "name": "Color",
          "values": colors
        }
      ]
      new_product.save
    end
    redirect_to root_path
  end

  def generateone
    uri = URI.parse("")
  end

  def deleteall
    ShopifyAPI::Product.find(10).destroy
    redirect_to root_path
  end

end
