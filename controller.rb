require('sinatra')
require('sinatra/contrib/all')
require_relative('models/city')
require_relative('models/country')
also_reload('./models/*')



get '/' do
  @countries = Country.all
  erb(:index)
end

get '/trips/new' do
  erb(:new)
end

post '/trips' do
  Country.new(params).save
  redirect to '/'
end


get '/trips/:id' do
  @country = Country.find(params['id'])
  @cities = Country.cities(params['id'])
  erb(:show)
end
