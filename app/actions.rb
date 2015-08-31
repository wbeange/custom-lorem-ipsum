helpers do
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

get '/' do
  if current_user
    erb :index
  else
    redirect '/login'
  end
end

get '/users' do
  @users = User.all
  erb :users
end

get '/login' do
  erb :login
end

get '/signup' do
  erb :signup
end

get '/logout' do
  session.clear
  redirect '/login'
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
