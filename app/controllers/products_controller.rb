class ProductsController < ApplicationController

  def show
  	@product = Product.find(params[:id])
    @product_id = @product.id
  	@inventories = @product.inventories.all
    @number = []
    (1..20).each { |num| @number << [num.to_s,num] }

    product_colors = []
    @inventories.each do | inventory |
    	product_colors << inventory.color
    end
    @product_colors = product_colors.uniq
    @all_sizes = ["xs","s","m","l","xl","xxl"]
  end

end
