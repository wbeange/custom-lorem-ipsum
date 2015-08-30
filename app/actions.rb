# Homepage (Root path)
get '/' do
  erb :index
end

get '/users' do
  @users = User.all
  erb :users
end

# post '/users' do

# end

# put '/users/:user_id' do

# end

# delete '/users/:user_id' do

# end
