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

get '/sights/:id/edit' do #edit sight info
  @sight = Sight.find(params['id'])
  erb(:"sights/edit")
end

post '/sights/:id' do #create a new Sight object and update sights db
  sight = Sight.new(params)
  sight.update
  # redirect to "/"
  redirect to "/sights/#{params['city_id']}"
end

post '/sights/:id/delete' do #delete a sight from a city
  @sight = Sight.find(params['id'])
  Sight.delete(params['id'])
  redirect to "/sights/#{@sight.city_id}"
end
