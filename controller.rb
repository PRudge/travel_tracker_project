require('sinatra')
require('sinatra/contrib/all')
require_relative('models/city')
require_relative('models/country')
also_reload('./models/*')



get '/' do
  @countries = Country.all
  erb(:index)
end

get '/countries/new' do
  erb(:new)
end

post '/countries' do
  Country.new(params).save
  redirect to '/'
end

get '/cities/new/:id' do
  @country = Country.find(params['id'])
  erb(:"cities/new")
end

post '/cities' do
  City.new(params).save
  # redirect to '/'
  redirect to "/trips/#{params['country_id']}"

end

get '/trips/:id' do
  @country = Country.find(params['id'])
  @cities = Country.cities(params['id'])
  erb(:show)
end
