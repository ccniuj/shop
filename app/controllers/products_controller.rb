class ProductsController < ApplicationController
  def remove
    @product = Product.find(params[:id])
    @cart = Cart.where(:user_id => current_user.id).take
    @cart = @cart.remove!(@product)
    flash[:alert] = "Product has been removed"
    redirect_to carts_path
  end
end
