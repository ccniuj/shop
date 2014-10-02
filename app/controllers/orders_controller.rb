class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id)
    @contacts = current_user.contacts.all
  end

  def show
    @order = Order.find(params[:id])
    @item = OrderInventory.where(order_id: @order.id)
    @inventories = Inventory.all
    @contacts = current_user.contacts.all
  end

  def create
    @order = current_user.orders.build(
      contact_id: current_user.contacts.first.id,
      status: 1,
      total_price: params[:total_price],
      pay_method: 1,
      ship_method: 1 )
    @order.save!
    add_order_inventory
    redirect_to edit_order_path(@order), :notice => "成功新增訂單"
  end

  def edit
    @order = Order.find(params[:id])
    @contact = current_user.contacts.first
  end

  def update
    create_contact
    # create or update 
    @order = Order.find(params[:id])
    @order.update(order_params) 
    redirect_to order_path(@order), :notice => "成功更新訂單"
  end

  private 

  def add_order_inventory
    @inventory = []
    params[:items].each do |z|
      @i = Inventory.find(z)
      @inventory << @i
    end

    @cart = Cart.where(user_id: current_user).take

    par = Hash.new
    count = 0
    @inventory.each do |i|
      par[:order_id] = @order.id
      par[:inventory_id] = i.id
      par[:amount] = params[:amount][count]
      @item = OrderInventory.new(par)
      @item.save!
      count += 1
      #@order.add!(i)
      #@cart.remove!(p)
    end
  end

  def create_contact
    @contact = current_user.contacts.new(contact_params)
    @contact.save!
  end
  
  def order_params
    params[:order][:contact_id] = current_user.contacts.last.id
    params.require(:order).permit(:contact_id, :pay_method, :ship_method, :status)
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :cellphone, :address)
  end
end
