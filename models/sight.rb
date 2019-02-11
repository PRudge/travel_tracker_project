require_relative('../db/sql_runner')

class Sight

  attr_accessor :city_id, :name, :comments
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @city_id = options['city_id'].to_i
    @name = options['name']
    @comments = options['comments']
  end

  def save()
    sql = "INSERT INTO sights
    (
      city_id,
      name,
      comments
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@city_id, @name, @comments]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id
  end

  def update()
    sql = "UPDATE sights
    SET
    (
      city_id,
      name,
      comments
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@city_id, @name, @comments, @id]
    SqlRunner.run(sql, values)
  end

  def format_name()
    formatted_name = @name.split.map(&:capitalize).join(' ')
    return formatted_name
  end

  def self.all()
    sql = "SELECT * FROM sights ORDER BY name"
    sight_data = SqlRunner.run(sql)
    sights = sight_data.map { |sight| Sight.new(sight) }
    return sights
  end

  def self.find(id)
    sql = "SELECT * FROM sights
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql ,values).first
    sight = Sight.new(result)
    return sight
  end

  def self.delete(id)
    sql = "DELETE FROM sights
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

end
