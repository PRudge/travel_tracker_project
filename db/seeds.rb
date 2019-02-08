require_relative('../models/city')
require_relative('../models/country')

country1 = Country.new({'name' => 'Scotland'})
country2 = Country.new({'name' => 'Thailand'})
country3 = Country.new({'name' => 'Nepal'})

country1.save()
country2.save()
country3.save()


city1 = City.new({
  'name' => 'Glasgow',
  'country_id' => country1.id,
  'visit_status' => 'visited' })
city2 = City.new({
  'name' => 'Edinburgh',
  'country_id' => country1.id,
  'visit_status' => 'visited' })
city3 = City.new({
  'name' => 'Inverness',
  'country_id' => country1.id,
  'visit_status' => 'to visit' })
city4 = City.new({
  'name' => 'Phucket',
  'country_id' => country2.id,
  'visit_status' => 'visited' })
city5 = City.new({
  'name' => 'Chiang Mai',
  'country_id' => country2.id,
  'visit_status' => 'to visit' })
city6 = City.new({
  'name' => 'Kathmandu',
  'country_id' => country3.id,
  'visit_status' => 'visited' })

city1.save()
city2.save()
city3.save()
city4.save()
city5.save()
city6.save()
