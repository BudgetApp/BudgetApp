class UsersController < ApplicationController

  before_action :set_user

  def feed
  end

  def live_feed
    # Later, we might want to return more info about the user in case we want to add profile pages
    if user = User.find_by(:hashed_uid => params[:uid])
      @user_name = user.name
      @expense = user.expenses.last
      @id = @expense.id
      @created_at = @expense.created_at
      @amount = @expense.amount
      @color = @expense.category.get_color
      @category = @expense.category.title
      @upvotes = @expense.votes.where(:vote_direction => true).count
      @downvotes = @expense.votes.where(:vote_direction => false).count
      respond_to do |format|
        format.js { }
      end
    end
  end

  def more_feed
    if @expenses = current_user.get_more_friend_expenses(params[:oldest])
      respond_to do |format|
        format.js { }
      end
    end 
  end

  # def feed_sum
  #   num_expenses = @user.get_friend_expenses.each { |expense| expense }.count
  #   expenses_sum = 0
  #   @user.get_friend_expenses.each { |expense|expenses_sum += expense.amount.to_f/100 }
  #   render :json => {:num_expenses => num_expenses, :expenses_sum => number_to_currency(expenses_sum)}
  # end

  def show
  end

  def confirm_hash_uid
    return_data = current_user.is_hashed_uid_a_friend?(params[:uid])
    render :json => {:confirmation => return_data}
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

  def weekly_expenses
    expenses = [
                {value: current_user.last_week_expenses_sum_for('Dining Out'), color: '#FF6B6B'},
                {value: current_user.last_week_expenses_sum_for('Groceries'), color: '#4ECDC4'},#Bright Blue
                {value: current_user.last_week_expenses_sum_for('Alcohol'), color: '#556270'}, #Dark grey
                {value: current_user.last_week_expenses_sum_for('Take-Out'), color: '#339194'},
                {value: current_user.last_week_expenses_sum_for('Public Transit'), color: '#025D8C'}, #bright green
                {value: current_user.last_week_expenses_sum_for('Cabs/Taxis'), color: '#F6D86B'},
                {value: current_user.last_week_expenses_sum_for('Clothing'), color: '#FB6B41'},
                {value: current_user.last_week_expenses_sum_for('Travel'), color: '#F10C49'},
                {value: current_user.last_week_expenses_sum_for('Cell Phone'), color: '#A70267'},
                {value: current_user.last_week_expenses_sum_for('Rent'), color: '#1693A7'},
                {value: current_user.last_week_expenses_sum_for('Utilities'), color: '#630947'},
                {value: current_user.last_week_expenses_sum_for('Books'), color: '#FF823A'},
                {value: current_user.last_week_expenses_sum_for('Gym'), color: '#95CFB7'},
                {value: current_user.last_week_expenses_sum_for('Misc.'), color: '#CC0C39' } # Darker Red
               ]
    render :json => {expenses: expenses}
  end

  def expense_popularity
    averages = Category.all.map do |category|
      current_user.average_popularity_for(category)
    end

    render :json => {averages: averages}
  end

  private
  def set_user
    @user = current_user
  end

end
