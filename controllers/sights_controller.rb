require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/sight.rb')
require_relative('../models/city.rb')
require_relative('../models/country.rb')
also_reload('../models/*')

get '/sights/:id' do #display sights for a city/country
  @city = City.find(params['id'])
  id = @city.country_id
  @country = Country.find(id)
  @sights = City.sights(params['id'])
  erb(:"sights/show")
end
