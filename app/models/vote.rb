class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :expense

  validates_uniqueness_of :user_id, scope: :expense_id
end
