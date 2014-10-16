class AddAttachmentAvatarToInventoryImages < ActiveRecord::Migration
  def self.up
    change_table :inventory_images do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :inventory_images, :avatar
  end
end
