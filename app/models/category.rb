class Category < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  has_many :expenses
  has_many :users, :through => :expenses

  CATEGORY_COLORS = {
                      'Dining Out' => '#FF6B6B',
                      'Groceries' => '#4ECDC4',
                      'Alcohol' => '#556270',
                      'Take-Out' => '#339194',
                      'Public Transportation' => '#C7F464',
                      'Cabs/Taxis' => '#F6D86B',
                      'Clothing' => '#FB6B41',
                      'Out of Town Travel' => '#F10C49',
                      'Cell Phone' => '#A70267',
                      'Rent' => '#1693A7',
                      'Utilities' => '#F8FCC1',
                      'Books' => '#FF823A',
                      'Gym' => '#95CFB7',
                      'Misc.' => '#CC0C39'
                    }

  def get_color
    CATEGORY_COLORS[self.title]
  end

  def get_human_readable_text(user)

    title = self.title
    user_total = user.last_week_expenses_sum_for(title)
    friends_average = user.weekly_friend_average_for(self)
    difference = ((user_total - friends_average).abs).to_f/100

    if user_total > friends_average
      "You spent #{number_to_currency(difference)} more than your friends on #{title} last week."
    elsif friends_average > user_total
      "You spent #{number_to_currency(difference)} less than your friends on #{title} last week."
    else
      "You and your friends spend the same amount on #{title} last week."
    end

  end

end
