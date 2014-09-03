class CartsController < ApplicationController
  before_action :authenticate_user!
  def index
    @cart = Cart.where(user_id: current_user.id)
    @item = CartProduct.where(cart_id: @cart)
    @product = Product.where(id: @item)
  end

  def show
  end

  # def destroy
  #   @item = CartProduct.where(cart_id: @cart_id)
  #   @cart_product = @item.where(product_id: params[:id])
  #   @cart_product.destroy
  #   redirect_to carts_path, :alert => 'Product has been removed'
  # end

  def remove
    @product = Product.find(params[:id])
    #@cart = Cart.find(current_user.id)
    @cart = Cart.where(:user_id => current_user.id)
    @cart = @cart.remove!(@product)
    flash[:alert] = "Product has been removed"
    redirect_to carts_path
  end
end


