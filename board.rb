load 'coordinate.rb'

class Board
  attr_accessor :coordinates

  def initialize
    @coordinates = Array.new
    for letter in ("A".."H") do
      count = 1
      while count < 9
        new_coordinate = Coordinate.new(letter + (count.to_s))
        @coordinates.push(new_coordinate)
        count += 1
      end
    end
  end

  def available_coordinates
    coordinates = Array.new
    self.coordinates.each do |coordinate|
      if (coordinate.hit == 0) && (coordinate.miss == 0)
        coordinates.push(coordinate)
      end
    end
    return coordinates
  end

  def draw_player_board
    count = 1
    print "\n"
    puts "- - - - - - - - - - - - - - - - -"
    print "Your Board:\n"
    print "\n"
    print (" # ")
    for i in (1..8) do
      print(" " + i.to_s + " ")

    end
    print("\n")
    self.coordinates.each() do |coordinate|
      if coordinate.xy[1] == "1"
        print " " + coordinate.xy[0]
          if (coordinate.has_ship == 1) && (coordinate.hit == 1)
            print "  x "
          elsif coordinate.has_ship == 1
            print "  # "
          elsif (coordinate.has_ship == 0) &&(coordinate.miss == 1)
            print "  o "
          else
            print "  _ "
          end
        count +=1

      elsif coordinate.xy[1] == "8"
        if (coordinate.has_ship == 1) && (coordinate.hit == 1)
          print " x \n"
        elsif coordinate.has_ship == 1
          print " # \n"
        elsif (coordinate.has_ship == 0) && (coordinate.miss == 1)
          print " o \n"
        else
          print(" _ \n")
        end

      else
        if (coordinate.has_ship == 1) && (coordinate.hit == 1)
          print " x "
        elsif coordinate.has_ship == 1
          print " # "
        elsif (coordinate.has_ship == 0) && (coordinate.miss == 1)
          print " o "
        else
          print(" _ ")
        end
      end
    end
    print "\n"
  end

  def draw_computer_board
    count = 1
    puts "- - - - - - - - - - - - - - - - -"
    print "Computer Board:\n"
    print "\n"
    print (" # ")
    for i in (1..8) do
      print(" " + i.to_s + " ")

    end
    print("\n")
    self.coordinates.each() do |coordinate|
      if coordinate.xy[1] == "1"
        print " " + coordinate.xy[0]
          if (coordinate.has_ship == 1) && (coordinate.hit == 1)
            print "  x "
          elsif (coordinate.has_ship == 0) &&(coordinate.miss == 1)
            print "  o "
          else
            print "  _ "
          end
        count +=1

      elsif coordinate.xy[1] == "8"
        if (coordinate.has_ship == 1) && (coordinate.hit == 1)
          print " x \n"
        elsif (coordinate.has_ship == 0) && (coordinate.miss == 1)
          print " o \n"
        else
          print(" _ \n")
        end

      else
        if (coordinate.has_ship == 1) && (coordinate.hit == 1)
          print " x "
        elsif (coordinate.has_ship == 0) && (coordinate.miss == 1)
          print " o "
        else
          print(" _ ")
        end
      end
    end
    print "\n"
  end
end
