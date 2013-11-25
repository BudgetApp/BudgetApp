class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, :through => :friendships
  # has_many :inverse_friendships, :class_name => 'Friendship',
  #   :foreign_key => 'friend_id'
  # has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :expenses
  has_many :categories, :through => :expenses

  def add_friend(friend)
    self.friendships.create(:friend => friend, :accepted => true)
    friend.friendships.create(:friend => self, :accepted => false)
  end

  def friend_names
    self.friends.pluck(:name)
  end

  def confirmed_friendship?(friendship)
    friendship.accepted? && friendship.inverse_friendship.accepted?
    # friendship.friend.friendships.where(:friend => self).accepted?
  end

  def get_friendships
    # Rewrite confirmed_friendship? and get_friendships
    # to only ask DB for specific friendships by ID
    self.friendships.select{|f| confirmed_friendship?(f)}
  end

  def pending_friendship_invitation?(friendship)
    friendship.accepted? && !friendship.inverse_friendship.accepted?
  end

  # Pending friendship requests that a user has initiated
  def pending_friendship_invitations
    self.friendships.select{|f| pending_friendship_invitation?(f)}
  end

  def pending_friendship_request?(friendship)
    !friendship.accepted? && friendship.inverse_friendship.accepted?
  end

  # Friendhip requests that a user hasn't accepted or declined
  def pending_friendship_requests
    self.friendships.select{|f| pending_friendship_request?(f)}
  end

end