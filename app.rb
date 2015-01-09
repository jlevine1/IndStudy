require 'sinatra'
require 'sinatra/activerecord'
require 'carrierwave'
require 'carrierwave/orm/activerecord'

require './environment'
# configure(:development) {set :database, "sqlite3:example4.sqlite3"}

require './models'
require 'bundler/setup'
require 'rack-flash'

set :sessions, true
use Rack::Flash, :sweep=>true

def current_user
	if session[:user_id]
		if @current_user=User.find(session[:user_id]).blank? then redirect '/sign-in' else @current_user=User.find(session[:user_id]) end
	else
		redirect '/sign-in'
	end
end

get '/' do
	redirect '/home'
end

get '/home' do
	erb :home
	# current_user
	# @profile=User.find(@current_user.id).profile
end

get '/sign-in' do
	erb :sign_in
end

post '/sign-in-process' do
	@user=User.find_by_username params[:username]
	if @user && @user.password==params[:password]
		flash[:message]="Success"
		session[:user_id]=@user.id
		redirect '/home'
	else
		flash[:message]="Failed"
		redirect '/sign-in'
	end
end

get '/sign-in2' do
	erb :sign_in2
end

post '/sign-in-process2' do
	@user=User.find_by_username params[:username]
	if @user && @user.password==params[:password]
		flash[:message]="Success"
		session[:user_id]=@user.id
		redirect '/delete-account'
	else
		flash[:message]="Failed"
		redirect '/sign-in2'
	end
end

get '/sign-up' do
	erb :sign_up
end

post '/sign-up-process' do
	if User.find_by_username(params[:username])
		flash[:message]="This username is already taken!"
		redirect '/sign-up'
	else
		User.create()
		Profile.create()
		@profile = Profile.last
		@user = User.last
		@profile.email = params[:email]
		@user.username = params[:username]
		@user.password = params[:password]
		@profile.user_id = @user.id
		@user.save
		@profile.save
		redirect '/sign-in'
	end
end

get '/user/:id' do
	@current_user=User.find(session[:user_id])
	@profile=User.find(session[:user_id]).profile
	@user=User.find(params[:id]);
	@current_profile=Profile.find_by_user_id(params[:id])
	erb :profile
end

get '/edit-profile' do
	@current_user=User.find(session[:user_id])
	@profile=User.find(@current_user.id).profile
	erb :edit_profile
end

post '/edit-profile-process' do
	current_user
	puts @current_user.id
	@profile=User.find(@current_user.id).profile
	@profile.email=params[:email]
	@current_user.password=params[:password]
	@current_user.save
	@profile.save
	redirect "/user/#{@current_user.id}"
end

post '/profile-post-process/:id' do
	a = User.find(session[:user_id])
	ProfilePosts.create(data:params[:content], author:(a.username), user_id:session[:user_id], profile_id:params[:id])
	redirect "/user/#{params[:id]}"
end

get '/delete-account' do
	User.destroy(session[:user_id])
	Profile.destroy(session[:user_id])

	
	a=ProfilePosts.where(user_id:session[:user_id]);
	a.each do |n|
	ProfilePosts.destroy(n.id)
	end

	session.clear
	redirect '/sign-in'
end
