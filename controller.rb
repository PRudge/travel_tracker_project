require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/sights_controller')
require_relative('controllers/cities_controller')
require_relative('controllers/countries_controller')
require_relative('controllers/trips_controller')

require_relative('models/sight.rb')
require_relative('models/city.rb')
require_relative('models/country.rb')
also_reload('models/*')

get '/' do
  # @countries = Country.all()
  @cities_visited = City.visited()
  @cities_not_visited = City.not_visited
  @cities = City.all()
  @sights = Sight.all()
  # @sights = Sight.all()
  erb( :index )
end
