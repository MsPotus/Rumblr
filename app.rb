
require 'sinatra'
require 'sinatra/activerecord'
require 'materialize-sass'
require 'shotgun'
# require 'bcrypt,''~> 3.1'
require_relative './models/User'
require_relative './models/Post'

# set :database, {adapter: 'postgresql', database: 'usersandposts'}
enable :sessions
set :sessions, true

# This is the home page
get '/' do
  erb :index
end

# show for signing in new users
get '/signup' do
  erb :'/signup'
end

# login in users who is already signup
get '/login' do
  erb :'/login'
end

# This is the logout page
get '/logout' do
    # Clear all sessions  
  session.clear
    # You can also just set the session to nil like this : session[:id] = nil
  redirect '/'
end



#gets other peoples blog posts
get '/posts/' do
    @users = User.find(session[:id]).all
    @posts = Post.where.not(user_id: @user.id).limit(20)
    erb :profile
end

# Get details on specific post
get '/post/:id' do
  @post = Post.find(params[:id])
    erb :post
end


# Get details on specific user and their posts
# get '/users/:id' do
#   @specific_user = User.find(params[:id])
#   @posts = Post.where(user_id: session[:id])
#   erb :profile
# end




# This sents a current user to their profile page 
get '/profile' do
  @user = User.find(session[:id])
  @posts = Post.where(user_id: session[:id])
  @postids =Post.where(user_id: session[:id]).pluck(:id)
    erb :profile
end

# get '/Account/:id' do 
#    @user = User.find(session[:id])
#    if @user != nil
#     session[:id] = @user.id
#   erb :profile
# else 
#   redirect '/'
  
# end


#Render form for editing a user
get '/profile/:id/edit' do 
    @specific_user = User.find(params[:id])
    erb :edit
end


# Search for user in login
post '/user/login' do 
  @user = User.find_by(email: params[:email], password: params[:password])
    if @user != nil
      session[:id] = @user.id
        redirect '/profile/:id'
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

# Create new user and track with session id from new route
post '/user/new' do 
    #Creating a new user based on the values from the form
    @newuser = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], birthday: params[:birthday], password: params[:password])
    #Setting the session with key of ID to be equal to the users id
    #Essentialy this "Logs them in"
    session[:id] = @newuser.id
    redirect '/profile'
end

# Delete a user and clear session
delete '/delete' do
    User.destroy(session[:id])
    session.clear
    redirect '/'
end

# edit '/edit'


private 
#Potentially useful function instead of checking if the user exists
def user_exists?
    (session[:id] != nil) ? true : false
end

def current_user
    User.find(session[:id])
end

# def hash_password (password)
#     BCryt::Password.create(password).to_s
# end

# def test_password(password, hash)
#     BCryt::Password.new(hash) == password
# end





