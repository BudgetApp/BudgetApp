class ExpensesController < ApplicationController

  def new
    @expense = Expense.new
  end

  def create
    expense_params[:amount]
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to current_user, notice: "Expense was successfully added."
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
