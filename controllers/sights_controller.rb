require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/sight')
require_relative('../models/city')
require_relative('../models/country')
also_reload('../models/*')

get '/sights/:id' do #display sights for a city/country
  @country = Country.find(params['id'])
  @cities = Country.cities(params['id'])
  @sights

  erb(:"sights/show")
end
