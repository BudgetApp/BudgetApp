class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :expense

  validates_uniqueness_of :user_id, scope: :expense_id

  #act of downvoting on something you have upvoted will delete that instance of the vote and replace it with a downvote, and vice versa
end
