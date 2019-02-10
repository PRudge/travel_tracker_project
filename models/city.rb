require_relative('../db/sql_runner')

class City

  attr_accessor :country_id, :name, :visit_status
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @country_id = options['country_id'].to_i
    @name = options['name']
    @visit_status = options['visit_status'].to_i
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

  def update()
    sql = "UPDATE cities
    SET
    (
      country_id,
      name,
      visit_status
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@country_id, @name, @visit_status, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM cities WHERE country_id = $1"
    values = [id]
    city_data = SqlRunner.run(sql, values)
    city = city_data.map { |city| City.new(city) }
    return city
  end

  def self.find(id)
    sql = "SELECT * FROM cities
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql ,values).first
    city = City.new(result)
    return city
  end

  def self.delete(id)
    sql = "DELETE FROM cities
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  #Extension
  def self.visited(visit_status)
    sql = "SELECT FROM cities
    WHERE visit_status = $1"
    values = [visit_status]
    city_data = SqlRunner.run(sql, values)
    cities = city_data.map { |city| City.new(city) }
    return cities
  end

end
