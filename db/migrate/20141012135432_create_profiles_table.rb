class CreateProfilesTable < ActiveRecord::Migration
  def change
  	create_table :profiles do |t|
  		t.string :email
  		t.datetime :created_at
  		t.integer :user_id
  	end
  end
end
