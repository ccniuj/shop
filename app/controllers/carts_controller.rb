class CartsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @is_checkout = false
    @cart = Cart.where(user_id: current_user.id).take
    @item = CartInventory.where(cart_id: @cart.id)
    @inventories = []
    @item_amount = []
    @item.each do |z|
      @i = Inventory.joins(:product).where(id: z.inventory_id).take
      @n = z.amount
      @inventories << @i
      @item_amount << @n
    end
  end

  def add
    @cart_id = Cart.where(user_id: current_user.id).first.id
    @item_num_sum = 0
    @item_amount_sum = 0
    params[:inventory].each do | key, val |
      unless val.to_i == 0
        CartInventory.create({cart_id: @cart_id, inventory_id: key, amount: val})
        @item_num_sum += 1
        @item_amount_sum += val.to_i
      end
    end
    if @item_num_sum > 0
      flash[:notice] = "已成功新增 #{@item_num_sum} 項商品，共 #{@item_amount_sum} 件"
    else
      flash[:alert] = "你並未新增任何商品至購物車"
    end
    redirect_to product_path(params[:product_id])
  end

  def operation
    unless params.has_key? :items
      flash[:alert] = "You have to select at least 1 product"
      redirect_to carts_path
    else
      if params.has_key? :checkout
        checkout
        @order = current_user.orders.new
        @contacts = current_user.contacts.all
        @contact = current_user.contacts.first
        render 'carts/checkout'
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

    @inventories = []
    @item_amount = []
    @total_price = 0

    params[:items].each do |i|
      @t = Inventory.find(i)
      @n = CartInventory.where(cart_id: current_user.id, inventory_id: i).take.amount
      @inventories << @t
      @item_amount << @n
      @total_price += @t.product.price * @n
    end

    # implement event algorothm here

  end
  
end