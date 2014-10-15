class MyDevise::RegistrationsController < Devise::RegistrationsController
  def new
    @contact = Contact.new
    super
  end

  def create 
    super
    if resource.save!
      @cart = Cart.new(user_id: resource.id)
      @cart.save
      @contact = Contact.new(user_id: resource.id, email: resource.email, 
      	name: params[:user][:contact][:name],
      	address: params[:user][:contact][:address],
      	cellphone: params[:user][:contact][:cellphone])
      @contact.save
      binding.pry
    end
  end
end