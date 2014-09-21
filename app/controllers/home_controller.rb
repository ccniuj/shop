class HomeController < ApplicationController

  def index
    @newest_products = Product.where("total_amout > total_popularity").order("created_at DESC").limit(10)
    @hotest_products = Product.where("total_amout > total_popularity").order("total_popularity DESC").limit(10)
  end

  def newest
  	@newest_products = Product.where("total_amout > total_popularity").order("created_at DESC")
  end

  def hotest
    @hotest_products = Product.where("total_amout > total_popularity").order("total_popularity DESC")
  end

end
