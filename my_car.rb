module Loadable
  def reverse
    puts "beep beep beep"
  end
end

class Vehicle

  attr_accessor :color
  attr_reader :year
  @@number_of_vehicles = 0

  VEHICLE = ""

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@number_of_vehicles += 1
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


  def self.calculate_mileage liters, kilometers
    "#{(liters.to_f/kilometers.to_f)*100} l/100km"
  end

  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end

  def age
    puts "The vehicle is #{calculate_age} years old"
  end

  private

  def calculate_age
    Time.now.year - self.year
  end
end

class MyCar < Vehicle

  VEHICLE = "Car"

  def to_s
    "I am a #{self.color} #{@model} of year #{self.year}, and I'm driving at #{@speed}"
  end
end

class MyTruck < Vehicle
  include Loadable
  VEHICLE = 'Truck'
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

puts MyCar.calculate_mileage 45, 550

polo = MyCar.new 2011, 'grey', 'VW Polo'

scania = MyTruck.new 2009, 'silver', 'scania truck'
Vehicle.number_of_vehicles
scania.reverse

puts MyTruck.ancestors

scania.age