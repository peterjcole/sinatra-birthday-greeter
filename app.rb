require 'sinatra'

get '/' do
  erb(:index)
end

post '/greet' do
  @day = params[:day]
  @month = params[:month]
  @name = params[:name]
  if @day == Time.now.strftime('%d') && @month = Time.now.strftime('%B')
    @greeting = "It's your birthday #{@name}!!!!!!!!!!!!!!!!!!!!!!!!!"
  else
    @greeting = "It is not your birthday #{@name} :("
  end
  erb(:greet)
end