class AvatarUploader < CarrierWave::Uploader::Base
	storage :file
	def store_dir
    	'my/upload/directory'
  	end
  
  	def extension_white_list
  		%w(jpg jpeg gif png)
  	end
end

class User <ActiveRecord::Base
	has_one :profile
	has_many :profile_posts
	has_many :posts
	has_many :user_followers
	has_many :users, through: :user_followers
	has_many :post_likes
	has_many :posts, through: :post_likes
	has_many :galleries
	has_many :gallery_likes 
	has_many :galleries, through: :gallery_likes
end

class Profile<ActiveRecord::Base
	belongs_to :user
	has_many :profile_posts
end

class Post<ActiveRecord::Base
	belongs_to :user
	has_many :post_likes
	has_many :users, through: :post_likes
	belongs_to :galleries
end

class ProfilePosts<ActiveRecord::Base
	belongs_to :user
	belongs_to :profile
end

class UserFollower<ActiveRecord::Base
	belongs_to :user
end

class PostLikes<ActiveRecord::Base
	belongs_to :user
	belongs_to :post
end

class Gallery<ActiveRecord::Base
	has_many :posts
	has_one :user
	mount_uploader :avatar, AvatarUploader
	has_many :gallery_likes
	has_many :users, through: :gallery_likes
end

class GalleryLikes<ActiveRecord::Base
	belongs_to :user
	belongs_to :galleries
end