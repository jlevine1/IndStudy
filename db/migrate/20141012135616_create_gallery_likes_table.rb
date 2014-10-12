class CreateGalleryLikesTable < ActiveRecord::Migration
   def change
  	create_table :gallery_likes do |t|
  		t.integer :user_id
  		t.integer :gallery_id
  	end
  end
end
