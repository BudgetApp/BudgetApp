class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :category, presence: true
end