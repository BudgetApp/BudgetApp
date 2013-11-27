class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :votes

  validates :category, presence: true
  validates :amount, presence: true
  # accepts_nested_attributes_for :category
end