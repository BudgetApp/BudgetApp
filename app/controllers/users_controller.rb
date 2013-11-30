class UsersController < ApplicationController

  before_action :set_user

  def feed
  end

  def show
  end

  def add_friends
  end

  def upvote_expense
    vote_expense(true)
  end

  def downvote_expense
    vote_expense(false)
  end

  def vote_expense(vote_direction)
    expense_id = params["expense_id"]
    expense = Expense.find(expense_id)
    new_vote = expense.votes.find_or_create_by(user_id: @user.id) 
    new_vote.vote_direction = vote_direction
    new_vote.save
    new_downvote_count = expense.votes.where(:vote_direction => false).count
    new_upvote_count = expense.votes.where(:vote_direction => true).count
    render :json => {:downvote_count => new_downvote_count, :upvote_count => new_upvote_count}
  end

  private
  def set_user
    @user = current_user
  end

end
