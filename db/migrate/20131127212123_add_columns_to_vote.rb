class AddColumnsToVote < ActiveRecord::Migration
  def change
    add_column :votes, :vote_direction, :boolean
    add_column :votes, :expense_id, :integer
    add_column :votes, :user_id, :integer
  end
end
