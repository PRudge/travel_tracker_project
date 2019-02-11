require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/sight')
require_relative('../models/city')
require_relative('../models/country')
also_reload('../models/*')


get '/countries' do #show all the countries (with links to saved cities)
    @countries = Country.all
  erb(:"countries/index")
end

get '/countries/new' do #form for a new country
  erb(:"countries/new")
end

post '/countries' do #input a new country
  id = Country.new(params).save
  redirect to "/cities/new/#{id}"
end

get '/countries/:id/edit' do #edit city info
  @country = Country.find(params['id'])
  erb(:"countries/edit")
end

post '/countries/:id' do #create a new Country object and update countries db
  country = Country.new(params)
  country.update
  redirect to "/countries"
end

post '/countries/:id/delete' do #delete a country and delete cascade all the cities
  Country.delete(params['id'])
  redirect to "/countries"
end
