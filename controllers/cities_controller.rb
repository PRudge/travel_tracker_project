require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/sight')
require_relative('../models/city')
require_relative('../models/country')
also_reload('../models/*')

get '/cities/new/:id' do #form for new city
  @country = Country.find(params['id'])
  erb(:"cities/new")
end

post '/cities' do #add a new city (to a specific country)
  City.new(params).save
  redirect to "/cities/#{params['country_id']}/view"
end

get '/cities/:id/view' do #display cities for a country
  @country = Country.find(params['id'])
  @visit_status = 0
  erb(:"cities/show")
end

get '/cities/:id/tosee' do #display cities for a country
  @country = Country.find(params['id'])
  @visit_status = 1
  erb(:"cities/show")
end

get '/cities/:id/edit' do #edit city info
  @city = City.find(params['id'])
  erb(:"cities/edit")
end

post '/cities/:id' do #create a new City object and update cities db
  city = City.new(params)
  city.update
  # redirect to "/"
  redirect to "/cities/#{params['country_id']}/view"
end

post '/cities/:id/delete' do #delete a city from a country
  @city = City.find(params['id'])
  keep = @city.country_id
  City.delete(params['id'])
  still_cities = Country.cities(keep)
  if still_cities.length != 0
    redirect to "/cities/#{keep}/view"
  else
   Country.delete(keep)
   redirect to "/countries"
 end
end
