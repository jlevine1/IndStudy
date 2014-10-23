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

# def current_user
# 	if session[:user_id]
# 		if @current_user=User.find(session[:user_id]).blank? then redirect '/sign-in' else @current_user=User.find(session[:user_id]) end
# 	else
# 		redirect '/sign-in'
# 	end
# end

get '/' do
	redirect '/home'
end

get '/home' do
	erb :home
	# current_user
	# @profile=User.find(@current_user.id).profile
end