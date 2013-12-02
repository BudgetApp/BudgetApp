class AddHashedUidToUser < ActiveRecord::Migration
  def change
    add_column :users, :hashed_uid, :string
  end
end
