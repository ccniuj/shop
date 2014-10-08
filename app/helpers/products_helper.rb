module ProductsHelper

  def check_num(inventories,color,size)
  	inventories.where({ color: color, size: size }).first
  end

end
