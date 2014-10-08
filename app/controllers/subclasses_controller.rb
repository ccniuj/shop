class SubclassesController < ApplicationController

  def show
  	@subclass = Subclass.find(params[:id])
  	@new_classified_products = @subclass.classified_products.has_invt.r_new.limit(20)
  	@hot_classified_products = @subclass.classified_products.has_invt.r_hot.limit(20)
  end

end
