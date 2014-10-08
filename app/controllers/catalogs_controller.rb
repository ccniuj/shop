class CatalogsController < ApplicationController

  def show
  	@catalog = Catalog.find(params[:id])
  	@subclasses = @catalog.subclasses.all
  end

end
