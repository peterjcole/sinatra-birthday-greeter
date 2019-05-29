require 'sinatra'

get '/' do
  erb(:index)
end

post '/greet' do
  erb(:greet)
end