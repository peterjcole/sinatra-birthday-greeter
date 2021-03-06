require 'sinatra/base'

class BirthdayGreeter < Sinatra::Base
  enable :sessions
  
  get '/' do
    erb(:index)
  end

  post '/birthday' do
    day = params[:day]
    month = params[:month]
    name = params[:name]

    if day.empty?
      $greeting = "I have no idea whether it's your birthday because you didn't tell me the day!"
      redirect '/greet'
    end

    days_until_birthday = calculate_days_until_birthday(day, month)
    if days_until_birthday.zero?
      $greeting = "It's your birthday #{name}!!!!!!!!!!!!!!!!!!!!!!!!!"
    else
      $greeting = "It is not your birthday #{name} :(. Don't be too sad though, it's in #{days_until_birthday} days"
    end

    redirect '/greet'
  end

  get '/greet' do
    erb(:greet)
  end 

  def calculate_days_until_birthday(day, month)
    today = Date.today
    birthday = Date.new(today.year, month.to_i, day.to_i)
    return (birthday - today).to_i if birthday >= today
    return (birthday.next_year - today).to_i
  end

  run! if app_file == $0

end