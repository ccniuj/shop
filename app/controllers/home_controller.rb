class HomeController < ApplicationController

  def index
    @newest_products = Product.has_invt.r_new.limit(10)
    @hotest_products = Product.has_invt.r_hot.limit(10)
  end

  def newest
    @newest_products = Product.has_invt.r_new
  end

  def hotest
    @hotest_products = Product.has_invt.r_hot.limit(10)
  end

end
