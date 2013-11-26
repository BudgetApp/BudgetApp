class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, :through => :friendships
  # has_many :inverse_friendships, :class_name => 'Friendship',
  #   :foreign_key => 'friend_id'
  # has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :expenses
  has_many :categories, :through => :expenses

  before_create :create_remember_token

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  ### Friendship Methods ###

  def add_friend(friend)
    self.friendships.create(:friend => friend, :accepted => true)
    friend.friendships.create(:friend => self, :accepted => false)
  end

  def friend_names
    self.friends.pluck(:name)
  end

  def confirmed_friendship?(friendship)
    friendship.accepted? && friendship.inverse_friendship.accepted?
  end

  def get_friendships
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

  ### Expense Data Methods ###

  def last_week_expenses
    self.expenses.where("created_at >= ?", Chronic.parse("one week ago"))
  end

  def last_month_expenses
    self.expenses.where("created_at >= ?", Chronic.parse("one month ago"))
  end

  def last_weekend_expenses
    self.expenses.where("created_at BETWEEN ? AND ?", Chronic.parse("last saturday"), Chronic.parse("last monday"))
  end

  def last_weekday_expenses
    self.last_week_expenses - self.last_weekend_expenses
  end

  def last_monthly_weekday_expenses
    self.last_month_expenses - self.last_monthly_weekend_expenses
  end

  def last_monthly_weekend_expenses
    self.last_month_expenses.select {|e| e.created_at.saturday? || e.created_at.sunday?}
  end

private 
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end