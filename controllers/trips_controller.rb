require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/sight')
require_relative('../models/city')
require_relative('../models/country')
also_reload('../models/*')


get '/trips/visited' do #show all the countries (with links to saved cities)
  @cities_visited = City.visited()
  @sights = Sight.all()
  erb(:"trips/index1")
end

get '/trips/tosee' do #show all the countries (with links to saved cities)
  @cities_not_visited = City.not_visited
  @sights = Sight.all()
  erb(:"trips/index2")
end

get '/trips/all' do #show all the countries (with links to saved cities)
  @cities = City.all()
  @sights = Sight.all()
  erb(:"trips/index3")
end
