class User < ActiveRecord::Base
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  serialize :info
  # has_many :inverse_friendships, :class_name => 'Friendship',
  #   :foreign_key => 'friend_id'
  # has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  # Pending Friendships method invitations + requests
  # Destroying leftover friendships
  has_many :expenses, dependent: :destroy
  has_many :categories, :through => :expenses
  has_many :votes
  validates_uniqueness_of :username

  before_create :create_remember_token

  ### Session Methods ###

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  ### Friendship Methods ###

  def add_friend(friend)
    return if self.friends.include?(friend)
    self.friendships.create(:friend => friend, :accepted => true)
    friend.friendships.create(:friend => self, :accepted => false)
  end

  def confirmed_friendship?(friendship)
    friendship.accepted? && friendship.inverse_friendship.accepted?
  end

  def get_friendships
    self.friendships.select{|f| confirmed_friendship?(f)}
  end

  def confirmed_friends
    self.get_friendships.map {|f| f.friend}
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

  # Returns an array of Facebook friends that also use the app
  def facebook_friends
    friends = GRAPH.get_connections(self.uid, "friends")
    friend_ids = friends.map {|f| f["id"]}
    User.where(uid: friend_ids) - self.friends
  end

  ### Expense Data Methods ###

  def last_week_expenses_categories
    category_ids = self.last_week_expenses.pluck(:category_id) if self.last_week_expenses
    category_ids.uniq!
    category_ids.map {|id| Category.find(id)}
  end

  def last_week_expenses_sum_for(category_title)
    last_week_expenses.select {|e| e.category.title == category_title}.map {|e| e.amount.to_i}.inject(:+)
  end

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

  def weekly_friend_average_for(category)
    averages_array = self.get_all_friend_expense_averages_for(category)
    total = averages_array[1].inject(:+)
    if total
      total / averages_array[0]
    else
      0
    end
  end

  ### Friend Feed Methods ###

  def get_all_friend_expense_averages_for(category)
    averages = self.confirmed_friends.map do |friend|
      friend.expenses.where(:category => category).average('amount')
    end.flatten
    [averages.length, averages]
  end

  def get_friend_expenses
    self.confirmed_friends.map do |friend|
      friend.expenses
    end.flatten.sort_by{|e| e.created_at}.reverse.slice(0,10)
  end

  def get_more_friend_expenses(created_at)
    self.confirmed_friends.map do |friend|
      friend.expenses.where("created_at < ?", created_at).limit(10)
    end.flatten.sort_by{|e| e.created_at}.reverse.slice(0,10)
  end

  def is_hashed_uid_a_friend?(hashed_uid)
    puts hashed_uid
    self.confirmed_friends.map {|f| f.hashed_uid}.include?(hashed_uid)
  end

  def broadcast_expense
    message = {:channel => FAYE_CHANNEL, :data => self.hashed_uid}
    uri = URI.parse(FAYE_ADDRESS)
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  ### Category Methods ###

  def average_popularity_for(category)
    expense_array = self.last_week_expenses.where(:category => category).map do |expense|
      expense.get_overall_vote_count
    end

    expense_array.inject(:+).to_f / expense_array.size
  end

  ### Helpful Methods ###

  def to_param
    self.username
  end

private 
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end