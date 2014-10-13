class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:create]

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

    @cart = Cart.where(user_id: current_user.id).take
    par = Hash.new
    count = 0
    @inventory.each do |i|
      par[:order_id] = @order.id
      par[:inventory_id] = i.id
      par[:amount] = params[:amount][count]
      @item = OrderInventory.new(par)
      @item.save!
      @cart.remove!(i)
      count += 1

      session[:cart] = nil
    end
  end

  def create_contact
    if current_user
      @contact = current_user.contacts.new(contact_params)
      @contact.save!
    else
      @new_user = User.create!({:email => params[:order][:contact][:email], 
        :password => params[:order][:contact][:password], 
        :password_confirmation => params[:order][:contact][:password_conformation] })
      Cart.create!({:user_id => @new_user.id})
      sign_in(@new_user)
      @contact = current_user.contacts.new(contact_params)
      @contact.save!
    end
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
