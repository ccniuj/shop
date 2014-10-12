class Admin::CatalogsController < ApplicationController
  before_action :find_catalog, only: [:edit, :update, :destroy]

  def index
  	@catalogs = Catalog.all
  end

  def new
  	@catalog = Catalog.new
  end

  def edit
  	@subclasses = @catalog.subclasses.all
  end

  def create
  	@catalog = Catalog.new(catalog_params)

  	if @catalog.save
      redirect_to new_admin_catalog_subclass_path(@catalog), notice: "目錄新增成功，請新增目錄的類別"
      # redirect_to @catalog, notice: "目錄新增成功，請新增目錄的類別"
  	else
      render :new, alert: "目錄新增失敗，必須輸入名稱與說明"
  	end
  end

  def update
  	if @catalog.update(catalog_params)
  		redirect_to edit_admin_catalog_path(@catalog), notice: "目錄變更完成"
    else
      # using render here will cause problem, need to fix later
    	redirect_to edit_admin_catalog_path(@catalog), alert: "目錄變更失敗，必須輸入名稱與說明"
    end
  end

  def destroy
  	@catalog.destroy
  	redirect_to admin_catalogs_path, notice: "成功刪除目錄"
  end

  private

  def catalog_params
  	params.require(:catalog).permit(:name, :description)
  end

  def find_catalog
  	@catalog = Catalog.find(params[:id])
  end
end
