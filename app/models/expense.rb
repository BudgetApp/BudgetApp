class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  # Scott thinks we should move these over to the User model
  scope :weekly, -> {where("created_at >= ?", Time.current - 1.week)}
  scope :monthly, -> {where("created_at >= ?", Time.current - 1.month)}
  scope :weekend, -> {where("created_at BETWEEN ? AND ?", 
    Date.new(Time.current.year, Time.current.month, Time.current.day).prev_week(:saturday), 
    Date.new(Time.current.year, Time.current.month, Time.current.day).prev_week(:monday))}

  # monthly_weekday scope
  # last_weekend
  # last_weekdays
  # USE CHRONIC!! Will make parsing the dates way simpler.
end