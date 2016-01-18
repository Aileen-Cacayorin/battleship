load 'coordinate.rb'

class Ship
  attr_accessor :coordinates

  def initialize
    @coordinates = Array.new
  end

  def add_coordinate(new_coordinate)
    @coordinates.push(new_coordinate)
  end


end
