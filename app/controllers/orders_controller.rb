class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @order = Order.find(params[:id])
    @item = OrderProduct.where(order_id: @order.id)
  end

  def create
    @order = current_user.orders.build()
    @order.save!

    add_order_product

    redirect_to order_path(@order)
  end

  private 

  def add_order_product
    @product = []
    params[:items].each do |i|
      @p = Product.find(i)
      @product << @p
    end

    @cart = Cart.where(user_id: current_user).take
    @product.each do |p|
      @order.add!(p)
      #@cart.remove!(p)
    end
  end
end
