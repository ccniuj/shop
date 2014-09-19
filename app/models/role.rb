class Role < ActiveRecord::Base
  
  resourcify
  include Authority::Abilities

  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  
  scopify
end
