class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :category, presence: true
  validates :amount, presence: true
  # accepts_nested_attributes_for :category
end