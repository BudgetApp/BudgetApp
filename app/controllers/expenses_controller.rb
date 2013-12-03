class ExpensesController < ApplicationController

  def new
    @expense = Expense.new
  end

  def create

    temp_expense_params = expense_params
    dollars = temp_expense_params[:amount].scan(/^(\d+)(\.\d{2})?$/).flatten.join
    
    if !dollars.empty?
      temp_expense_params.merge!(:amount => (dollars.to_f * 100).to_i)
    else
      flash[:notice] = "Please enter expense amount in the following format: 10.25"
    end

    @expense = current_user.expenses.build(temp_expense_params)
    if !dollars.empty? && @expense.save
      current_user.broadcast_expense
      redirect_to current_user
    else
      render action: 'new'
    end
  end

  def update
  end

  def destroy
    @expense.destroy
  end

  private
  def expense_params
    params.require(:expense).permit(:amount, :category_id)
  end
end
