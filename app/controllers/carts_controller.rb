class CartsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @is_checkout = false
    @cart = Cart.where(user_id: current_user.id).take
    @item = CartInventory.where(cart_id: @cart.id)
    @inventory = []
    @item_amount = []
    @item.each do |z|
      @i = Inventory.joins(:product).where(id: z.inventory_id).take
      @n = z.amount
      @inventory << @i
      @item_amount << @n
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

  def remove
    if params.has_key? :items
      params[:items].each do |i|
        @inventory = Inventory.find(i)
        @cart = Cart.where(:user_id => current_user.id).take
        @cart.remove!(@inventory)
      end
      flash[:alert] = "Product has been removed"
    else
      @inventory = Inventory.find(params[:id])
      @cart = Cart.where(:user_id => current_user.id).take
      @cart.remove!(@inventory)
      flash[:alert] = "Products have been removed"
      redirect_to carts_path
    end
  end
  
  private

  def checkout
    @is_checkout = true
    @inventory = []
    params[:items].each do |i|
      @t = Inventory.find(i)
      @inventory << @t
    end
  end
  
end