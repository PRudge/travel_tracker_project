require('sinatra')
require('sinatra/contrib/all')
require_relative('models/city')
require_relative('models/country')
also_reload('./models/*')


get '/' do
  @countries = Country.all
  erb(:index)
end

get '/trips/:id' do
  @country = Country.find(params['id'])
  @cities = City.find(params['id'])
  erb(:show)
end
