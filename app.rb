require 'sinatra'
require 'sinatra/activerecord'
require 'materialize-sass'
require 'shotgun'
require_relative './models/User'
require_relative './models/Post'

set :database, {adapter: 'postgresql', database: 'usersandposts'}
enable :sessions

get '/' do
  erb :index
end

get '/post/:id' do
  @post = Post.find(params[:id])
    erb :post
end

get '/users/:id' do
    @other_user = User.find(params[:id])
    @posts = Post.where(user_id: session[:id])
    erb :other_user
end

get '/signup' do
  erb :'/signup'
end

get '/logout' do
  session.clear
    redirect '/'
end

get '/login' do
  erb :'/login'
  
end

get '/profile' do
  @user = User.find(session[:id])
  @posts = Post.where(user_id: session[:id])
    erb :profile
end



get '/logout' do
    # Clear all sessions  
  session.clear
    # You can also just set the session to nil like this : session[:id] = nil
  redirect '/login'
end

post '/user/login' do 
  @user = User.find_by(email: params[:email], password: params[:password])
    if @user != nil
      session[:id] = @user.id
        erb :profile
    else   
        #Could not find this user. Redirecting them to the signup page
        redirect '/'
    end 
end

    #creating a new post" 
post '/post/new' do
    @newpost = Post.create(post_name: params[:post_name], content: params[:content], user_id: session[:id])
    redirect '/profile'
    end

post '/user/new' do 
    #Creating a new user based on the values from the form
    @newuser = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], birthday: params[:birthday], password: params[:password])
    #Setting the session with key of ID to be equal to the users id
    #Essentialy this "Logs them in"
    session[:id] = @newuser.id
    redirect '/profile'

end


delete '/delete' do
    User.destroy(session[:id])
    session.clear
    redirect '/'
end




private 
#Potentially useful function instead of checking if the user exists
def user_exists?
    (session[:id] != nil) ? true : false
end

def current_user
    User.find(session[:id])
end