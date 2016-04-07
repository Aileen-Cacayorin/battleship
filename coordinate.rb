class Coordinate
  attr_accessor :xy, :has_ship, :hit, :miss

   def initialize(xy)
     @xy = xy
     @x = xy[0].upcase
     @y = xy[1].to_i
     @has_ship = 0
     @hit = 0
     @miss = 0
    end

    def is_hit(coordinate)
      if @hit == 0
        return false
      elsif @hit == 1
        return true
      end
    end
end
