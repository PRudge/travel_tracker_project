require_relative('../db/sql_runner')

class City

  attr_accessor :country_id, :name, :visit_status
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @country_id = options['country_id'].to_i
    @name = options['name']
    @visit_status = options['visit_status']
  end

  def save()
    sql = "INSERT INTO cities
    (
      country_id,
      name,
      visit_status
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@country_id, @name, @visit_status]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id
  end

  def self.all(id)
    sql = "SELECT * FROM cities WHERE country_id = $1"
    values = [id]
    city_data = SqlRunner.run(sql, values)
    city = city_data.map { |city| City.new(city) }
    return city
  end

end
