class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :facebook_id
      t.string :facebook_token

      t.timestamps
    end
  end
end
