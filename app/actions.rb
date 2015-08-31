helpers do
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

#
# authentication CRUD
#

get '/' do
  if current_user
    erb :index
  else
    redirect '/login'
  end
end

get '/login' do
  erb :login
end

post '/login' do
  email = params[:email]
  password = params[:password]
  user = User.find_by_email(email)
  if user && user.password == password
    session[:user_id] = user.id
    redirect '/'
  else
    redirect '/login'
  end
end

get '/signup' do
  erb :signup
end

post '/signup' do
  user_params = {
    name: params[:name],
    password: params[:password],
    email: params[:email]
  }

  user = User.find_by_email(user_params[:email])
  if user
    session[:user_id] = user.id
    redirect '/login'
  else
    user = User.create(user_params)
    if user
      session[:user_id] = user.id
      redirect '/'
    else
      redirect '/signup'
    end
  end
end

get '/logout' do
  session.clear
  redirect '/login'
end

get '/users' do
  @users = User.all
  erb :users
end

#
# lorem ipsums CRUD
#

get '/lorem_ipsums' do
  @records = LoremIpsum.where(:user_id => current_user.id)
  erb :lorem_ipsums_index
end

get '/lorem_ipsums/:id' do
  @record = LoremIpsum.find(params[:id])
  erb :lorem_ipsums_show
end

post '/lorem_ipsums' do
end

put '/lorem_ipsums' do
end

delete '/lorem_ipsums/:id' do
  record = LoremIpsum.find(params[:id])
  record.destroy if record
  redirect '/'
end
