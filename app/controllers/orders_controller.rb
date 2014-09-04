class OrdersController < ApplicationController
  def index
  end

  def new
    @product = []
    params[:items].each do |i|
      @p = Product.find(i)
      @product << @p
    end
  end
end
