class Admin::SubclassesController < ApplicationController
  before_action :get_catalog_and_subclass, only: [:edit, :update, :destroy]

  def new
    @catalog = Catalog.find(params[:catalog_id])
    @subclass = @catalog.subclasses.new
  end

  def edit
    @products = @subclass.classified_products
  end

  def create
    @catalog = Catalog.find(params[:catalog_id])
    @subclass = @catalog.subclasses.new(subclass_params)
    
    if @subclass.save
      # should redirect_to add product to SubclassProduct page
      redirect_to edit_admin_catalog_path(@catalog), notice: "類別新增完成"
    else
      flash[:alert] = "類別新增失敗，必須輸入名稱與說明"
      render :new
    end
  end

  def update
    if @subclass.update(subclass_params)
      redirect_to edit_admin_catalog_path(@catalog), notice: "類別更新成功"
    else
      # using render here will cause problem, need to fix later
      redirect_to edit_admin_catalog_path(@catalog), alert: "類別更新失敗，必須輸入名稱與說明"
    end
  end

  def destroy
    @subclass.destroy
    redirect_to edit_admin_catalog_path(@catalog), notice: "成功刪除類別"
  end

  def product
    @catalog = Catalog.find(params[:catalog_id])
    @subclass = @catalog.subclasses.find(params[:subclass_id])
    @catalogs = Catalog.all.in_groups_of(4)
    @products = Product.all
  end

  def klassify
    old_classified_product = []
    if SubclassProduct.where(subclass_id: params[:subclass_id].to_i)
      SubclassProduct.where(subclass_id: params[:subclass_id].to_i).each do |item|
        old_classified_product << item.product_id
      end
    end
    params[:products] ? new_classified_product = params[:products].each(&:to_i) : new_classified_product = []
    shall_add = new_classified_product - old_classified_product
    shall_rm  = old_classified_product - new_classified_product
    
    shall_add.each do |new_add_id|
      SubclassProduct.create({subclass_id: params[:subclass_id].to_i, product_id: new_add_id})
    end

    shall_rm.each do |new_rm_id|
      SubclassProduct.find_by_product_id(new_rm_id).destroy
    end

    redirect_to admin_catalog_subclass_product_path(params[:catalog_id].to_i,params[:subclass_id].to_i)
    flash[:notice] = "已完成產品變更"
  end

  private

  def subclass_params
    params.require(:subclass).permit(:name, :description)
  end

  def get_catalog_and_subclass
    @catalog = Catalog.find(params[:catalog_id])
    @subclass = @catalog.subclasses.find(params[:id])
  end
end
