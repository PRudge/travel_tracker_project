require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/city')
require_relative('../models/country')
also_reload('../models/*')


get '/countries' do
    @countries = Country.all
  erb(:"countries/index")
end

get '/countries/new' do
  erb(:"countries/new")
end

post '/countries' do
  Country.new(params).save
  redirect to '/countries'
end

get '/countries/:id' do
  @country = Country.find(params['id'])
  @cities = Country.cities(params['id'])
  erb(:"countries/show")
end

post '/countries/:id/delete' do #delete a country and delete cascade all the cities
  Country.delete(params['id'])
  redirect to "/countries"
end
