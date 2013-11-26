class AddInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :info, :string
  end
end
