require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/city')
require_relative('../models/country')
also_reload('../models/*')

get '/cities/new/:id' do
  @country = Country.find(params['id'])
  erb(:"cities/new")
end

post '/cities' do
  City.new(params).save
  # redirect to '/'
  redirect to "/countries/#{params['country_id']}"
end
