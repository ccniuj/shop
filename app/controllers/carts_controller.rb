class CartsController < ApplicationController
  before_action :authenticate_user!
  def index
    @cart = Cart.where(user_id: current_user.id).take
    @item = CartProduct.where(cart_id: @cart.id)
    @product = []
    @item.each do |i|
      @p = Product.where(id: i.product_id).take
      @product << @p
    end
    
  end

  def show
  end

  def destroy
    @cart = Cart.where(user_id: current_user.id)
    @item = CartProduct.where(cart_id: @cart)
    @cart_product = @item.where(product_id: params[:id])
    @cart_product.destroy
    redirect_to carts_path, :alert => 'Product has been removed'
  end

  def remove
    @product = Product.find(params[:id])
    @cart = Cart.where(:user_id => current_user.id).take
    @cart = @cart.remove!(@product)
    flash[:alert] = "Product has been removed"
    redirect_to carts_path
  end
end


