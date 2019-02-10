require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/sight.rb')
require_relative('../models/city.rb')
require_relative('../models/country.rb')
also_reload('../models/*')

get '/sights/new/:id' do #form for new sight
  @city = City.find(params['id'])
  erb(:"sights/new")
end

post '/sights' do #add a new sight (for a city in a country
  Sight.new(params).save
  redirect to "/sights/#{params['city_id']}"
end

get '/sights/:id' do #display sights for a city/country
  @city = City.find(params['id'])
  id = @city.country_id
  @country = Country.find(id)
  @sights = City.sights(params['id'])
  erb(:"sights/show")
end
