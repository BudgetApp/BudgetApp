class UsersController < ApplicationController

  before_action :set_user

  def feed
  end

  def show
  end

  def add_friends
  end

  def upvote_expense
    expense_id = params["expense_id"]
    expense = Expense.find(expense_id)
    new_vote = expense.votes.create(vote_direction: true, user_id: @user.id)
    new_vote.save
    new_upvote_count = expense.votes.where(:vote_direction => true).count
    render :json => {:upvote_count => new_upvote_count}
  end

  def downvote_expense
    expense_id = params["expense_id"]
    expense = Expense.find(expense_id)
    new_vote = expense.votes.create(vote_direction: false, user_id: @user.id) 
    new_vote.save
    new_downvote_count = expense.votes.where(:vote_direction => false).count
    render :json => {:downvote_count => new_downvote_count}
  end

  private
  def set_user
    @user = current_user
  end

end
