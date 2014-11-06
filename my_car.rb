class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def accelerate
    @speed += 10
  end

  def brake
    @speed -= 10
  end

  def shut_off
    @speed = 0
  end

  def current_speed
    puts "you're going at #{@speed}"
  end

  def spray_paint color
    self.color = color
  end

end

golf = MyCar.new(2013, 'black', 'VW Golf')

golf.accelerate
golf.current_speed
golf.accelerate
golf.accelerate
golf.current_speed

golf.brake
golf.current_speed

golf.shut_off
golf.current_speed
puts golf.year
puts golf.color
golf.spray_paint 'yellow'
puts golf.color