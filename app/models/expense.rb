class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  scope :weekly, -> {where("created_at >= ?", Time.current - 1.week)}
  scope :monthly, -> {where("created_at >= ?", Time.current - 1.month)}
  scope :weekend, -> {where("created_at BETWEEN ? AND ?", Date.new(Time.current.year, Time.current.month, Time.current.day).prev_week(:saturday), Date.new(Time.current.year, Time.current.month, Time.current.day).prev_week(:monday))}
  scope :weekdays, -> {}

  def weekly_expenses

  end

  def monthly_expenses
  end

  def weekend_expenses
  end

  def weekday_expenses
  end

end
