class Category < ActiveRecord::Base
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

end
