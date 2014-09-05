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

  def operation
    unless params.has_key? :items
      flash[:alert] = "You have to select at least 1 product"
      redirect_to carts_path
    else
      if params.has_key? :checkout
        checkout
        render "carts/checkout"
      elsif params.has_key? :remove
        remove
        redirect_to carts_path
      end
    end
  end

  private

  def checkout
    @item = []
    params[:items].each do |i|
      @t = Product.find(i)
      @item << @t
    end
  end
  
  def remove
    params[:items].each do |i|
      @product = Product.find(i)
      @cart = Cart.where(:user_id => current_user.id).take
      @cart.remove!(@product)
    end
    flash[:alert] = "Product has been removed"
  end
  
end