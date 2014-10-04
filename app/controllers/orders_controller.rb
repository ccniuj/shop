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

  def new
  end

  def create
    # @order = current_user.orders.build(
    #   contact_id: current_user.contacts.first.id,
    #   status: 1,
    #   total_price: params[:total_price],
    #   pay_method: 1,
    #   ship_method: 1 )

    if params[:contact_id].empty?
      create_contact
      @@contact_id = current_user.contacts.last.id
    else
      update_contact
      @@contact_id = params[:contact_id]
    end

    @order = current_user.orders.new(order_params)
    @order.save!
    add_order_inventory
    redirect_to orders_path, :notice => "成功新增訂單"
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
  
  def update_contact
    @contact = current_user.contacts.find(params[:contact_id])
    @contact.update(contact_params)
  end

  def order_params
    params[:order][:contact_id] = @@contact_id
    params[:order][:status] = 1
    params[:order][:total_price] = params[:total_price]
    params.require(:order).permit(:contact_id, :pay_method, :ship_method, :status, :total_price)
  end

  def contact_params
    params[:contact] = params[:order][:contact]
    params.require(:contact).permit(:name, :email, :cellphone, :address)
  end
end
