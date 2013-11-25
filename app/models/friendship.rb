class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User', :foreign_key => 'friend_id'

  def accepted?
    self.accepted
  end

  def inverse_friendship
    self.friend.friendships.where(:friend => self.user).first
  end

  def accept_friendship
    self.update(:accepted => true)
  end

  def decline_friendship
    self.destroy
  end

end
