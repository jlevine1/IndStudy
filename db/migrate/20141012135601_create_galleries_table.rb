class CreateGalleriesTable < ActiveRecord::Migration
  def change
  	create_table :galleries do |t|
  		t.string :title
  		t.string :rating
  		t.string :avatar
  		t.string :review
  		t.integer :user_id
  		t.boolean :approved
  	end
  end
end
