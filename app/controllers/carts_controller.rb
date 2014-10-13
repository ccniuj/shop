class CartsController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :add]
  before_action :session_to_cart

  def index
    @is_checkout = false
    if current_user
      index_cart
    else
      index_session
    end
  end

  def index_cart
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

  def index_session
    @cart = 1
    @inventories = []
    @item_amount = []
    if session[:cart] 
      session[:cart].each do |key, val|
        @i = Inventory.joins(:product).where(id: key).take
        @n = val
        @inventories << @i
        @item_amount << @n
      end
    end
  end

  def add
    @item_num_sum = 0
    @item_amount_sum = 0
    
    if current_user
      add_to_cart
    else 
      add_to_session
    end

    if @item_num_sum > 0
      flash[:notice] = "已成功新增 #{@item_num_sum} 項商品，共 #{@item_amount_sum} 件"
    else
      flash[:alert] = "你並未新增任何商品至購物車"
    end
    redirect_to product_path(params[:product_id])
  end
  
  def add_to_cart
    @cart_id = Cart.where(user_id: current_user.id).first.id
    params[:inventory].each do | key, val |
      @cart_invt = CartInventory.where(cart_id: @cart_id, inventory_id: key).first
      unless val.to_i == 0
        if @cart_invt
          new_val = val.to_i + @cart_invt.amount
          CartInventory.update(@cart_invt.id,{cart_id: @cart_id, inventory_id: key, amount: new_val})
          @item_num_sum += 1
          @item_amount_sum += val.to_i
        else
          CartInventory.create({cart_id: @cart_id, inventory_id: key, amount: val.to_i})
          @item_num_sum += 1
          @item_amount_sum += val.to_i
        end
      end
    end
  end

  def add_to_session
    params[:inventory].each do | key, val |
      unless val.to_i == 0 
        unless session[:cart]
          session[:cart] = {key.to_sym => val.to_i}
        else 
          if session[:cart].has_key? key
            session[:cart][key] += val.to_i
          else
            session[:cart].store(key, val.to_i)
          end
        end
        @item_num_sum += 1
        @item_amount_sum += val.to_i
      end
    end
  end

  def operation
    unless params.has_key? :items
      flash[:alert] = "您必須選擇至少一件商品"
      redirect_to carts_path
    else
      if params.has_key? :checkout
        checkout
        render 'carts/checkout'
      elsif params.has_key? :remove
        remove
        redirect_to carts_path
      end
    end
  end

  def remove
    if current_user
      remove_cart
    else
      remove_session
    end
  end
  
  def remove_cart
    params[:items].each do |i|
      @inventory = Inventory.find(i)
      @cart = Cart.where(:user_id => current_user.id).take
      @cart.remove!(@inventory)
    end
    flash[:alert] = "已將商品從購物車中移除"
  end

  def  remove_session
    params[:items].each do |i|
      session[:cart].delete(i)
    end
    flash[:alert] = "已將商品從購物車中移除"
  end

  private

  def session_to_cart
    if session[:cart] && current_user
      cart = current_user.carts.take
      session[:cart].each do |key, val|
        CartInventory.create({cart_id: cart.id, inventory_id: key, amount: val})
      end
      session[:cartt] = nil
    end
  end

  def checkout
    @is_checkout = true

    @inventories = []
    @item_amount = []
    @total_price = 0
    if current_user 
      checkout_cart
    else
      checkout_session
    end
  end
  
  def checkout_cart
    @order = current_user.orders.new
    @contacts = current_user.contacts.all
    @contact = current_user.contacts.first
        
    params[:items].each do |i|
      @t = Inventory.find(i)
      @n = CartInventory.where(cart_id: current_user.carts.take.id, inventory_id: i).take.amount
      @inventories << @t
      @item_amount << @n
      @total_price += @t.product.price * @n
    end

    # implement event algorothm here

  end

  def checkout_session
    @order = Order.new
    @contact = Contact.new    
    params[:items].each do |i|
      @t = Inventory.find(i)
      @n = session[:cart][i]
      @inventories << @t
      @item_amount << @n
      @total_price += @t.product.price * @n
    end

    # implement event algorothm here

  end  
end