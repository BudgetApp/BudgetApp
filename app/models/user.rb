class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, :through => :friendships
  # has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id'
  # has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :expenses
  has_many :categories, :through => :expenses

  def add_friend(friend)
    self.friendships.create(:friend => friend)
    friend.friendships.create(:friend => self)
  end

  def friend_names
    self.friends.pluck(:name)
  end

end