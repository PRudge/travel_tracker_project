require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/sight')
require_relative('../models/city')
require_relative('../models/country')
also_reload('../models/*')


get '/trips/visited' do #show all the countries (with links to saved cities)
  @title = "Trips Taken"
  @cities = City.visited()
  @sights = Sight.all()
  erb(:"trips/index")
end

get '/trips/tosee' do #show all the countries (with links to saved cities)
  @title = "Trips Planned"
  @cities = City.not_visited()
  @sights = Sight.all()
  erb(:"trips/index")
end

get '/trips/all' do #show all the countries (with links to saved cities)
  @title = "All My Trips"
  @cities = City.all()
  @sights = Sight.all()
  erb(:"trips/index")
end
