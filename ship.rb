load 'coordinate.rb'

class Ship
  attr_accessor :coordinates

  def initialize
    @coordinates = Array.new
  end

  def add_coordinate(new_coordinate)
    @coordinates.push(new_coordinate)
  end

  def check_sink
    coordinates.each do |coordinate|
      if coordinate.hit == 0
        return false
      else
        next
      end
    end
    return true
  end


end
