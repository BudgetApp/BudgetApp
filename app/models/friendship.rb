class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User', :foreign_key => 'friend_id'

  def inverse_friendship
    self.friend.friendships.where(:friend => self.user)
  end

end
