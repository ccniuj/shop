class UserAuthorizer < ApplicationAuthorizer

  def self.readable_by?(user)
    user.has_role? :admin
  end

  def deletable_by?(user)
  	user.has_role? :admin
  end

end