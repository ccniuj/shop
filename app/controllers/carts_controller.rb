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
     #send(params[:commit].downcase)
     if params[:checkout] != nil
       #render plain: params[:items].inspect
       render plain: "checkout"
     end
     if params[:remove] != nil
       #render plain: params[:items].inspect
       remove
       redirect_to carts_path
     end

     #render plain: params[:checkout].inspect
  end

  def checkout
  end
  
  def remove
    params[:items].each do |i|
      @product = Product.find(i)
      @cart = Cart.where(:user_id => current_user.id).take
      @cart = @cart.remove!(@product)
    end
    flash[:alert] = "Product has been removed"
  end
  
end


