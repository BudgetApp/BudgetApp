class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :votes

  validates :category, presence: true
  validates :amount, presence: true
  # accepts_nested_attributes_for :category

  def get_overall_vote_count
    upvotes = self.votes.where(:vote_direction => true).count
    downvotes = self.votes.where(:vote_direction => false).count

    upvotes - downvotes
  end

end