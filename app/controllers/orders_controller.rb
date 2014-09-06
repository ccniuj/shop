class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @order = Order.find(params[:id])
    @item = OrderProduct.where(order_id: @order.id)
  end

  def create
    @order = current_user.orders.build(:total_price => "99")
    @order.save!

    add_order_product

    redirect_to edit_order_path(@order)
  end

  def edit
    @order = Order.find(params[:id])
    @contact = Contact.new
  end

  def update
    update_contact
    @order = Order.find(params[:id])
    @order.update(order_params(@order)) 
    flash[:notice] = "Order has been updated"
    redirect_to carts_path
    #render plian: "hello"
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

  def update_contact
    @contact = current_user.contacts.build
    @contact.save!
    @contact.update(contact_params)
  end

  def order_params(o)
    params[:order][:contact_id] = o.id
    params[:order][:status] = "1"
    params.require(:order).permit(:contact_id, :pay_method, :ship_method, :status)  
  end

  def contact_params
    params.require(:contact).permit(:name, :cellphone, :address)
  end
end
