class CategoriesController < ApplicationController

  def get_random_category
    @category = current_user.last_week_expenses_categories.sample
    @user = current_user
    respond_to do |format|
      format.js { }
    end
    # render json: {category: current_user.last_week_expenses_categories.sample, user_amount: user_amount, friend_average: friend_average}
  end

end