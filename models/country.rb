require_relative('../db/sql_runner')

class Country

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO countries
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    id = result.first["id"]
    @id = id.to_i
    return @id
  end

  def update()
    sql = "UPDATE countries
    SET name = $1
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def format_name()
    formatted_name = @name.split.map(&:capitalize).join(' ')
    return formatted_name
  end

  def self.all()
    sql = "SELECT * FROM countries ORDER by name"
    country_data = SqlRunner.run(sql)
    country = country_data.map { |country| Country.new(country) }
    return country
  end

  def self.find(id)
    sql = "SELECT * FROM countries
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql ,values).first
    country = Country.new(result)
    return country
  end

  def self.cities(id)
    sql = "SELECT * FROM cities
    WHERE country_id = $1 ORDER BY name"
    values = [id]
    city_data = SqlRunner.run(sql, values)
    city = city_data.map { |city| City.new(city) }
    return city
  end

  def self.visited(visit_status)
    sql = "SELECT FROM cities
    WHERE visit_status = $1"
    values = [visit_status]
    city_data = SqlRunner.run(sql, values)
    city = city_data.map { |city| City.new(city) }
    return city
  end

  def self.delete(id)
    sql = "DELETE FROM countries
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end



end
