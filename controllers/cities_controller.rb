require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/city')
require_relative('../models/country')
also_reload('../models/*')

get '/cities/new/:id' do #add a new city
  @country = Country.find(params['id'])
  erb(:"cities/new")
end

post '/cities' do #add a new city (to a specific country)
  City.new(params).save
  redirect to "/countries/#{params['country_id']}"
end

get '/cities/:id/edit' do #edit city info
  @city = City.find(params['id'])
  erb(:"cities/edit")
end

post '/cities/:id' do #create a new City object and update cities db
  city = City.new(params)
  city.update
  redirect to "/countries"
end

post '/cities/:id/delete' do #delete a city from a country
  City.delete(params['id'])
  # redirect to "/countries/#{params['countr_id']}"
  redirect to "/countries"
end
