class MyDevise::RegistrationsController < Devise::RegistrationsController
  def create 
    super
    if resource.save!
      @cart = Cart.new(user_id: resource.id)
      @cart.save
      binding.pry
      @contact = Contact.new(user_id: resource.id)
    end
  end
end