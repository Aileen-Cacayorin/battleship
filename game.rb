load 'coordinate.rb'
load 'ship.rb'
load 'player.rb'
load 'board.rb'

class Game
  attr_accessor :player, :computer, :current_player, :player_board, :computer_board

  def initialize
    @player = Player.new
    @computer = Player.new
    @current_player = @player
    @player.board = Board.new
    @computer.board= Board.new
  end

# Gets coordinate input from player
  def get_coordinate
    @xy = gets.strip
    @x = @xy[0].upcase
    @y = @xy[1].to_i
    @coordinate = @x + @y.to_s
    if /^[a-hA-H][1-8]/.match(@coordinate)
      return @coordinate
    else
      puts "Invalid coordinate. Please try again."
      get_coordinate
    end
  end

#Player selects ship locations
  def place_player_ships
    @player.board.draw_player_board()
    sleep 1
    print "Time to place your ships! You will have a total of 4 ships and each ship is 3 coordinates in length. "
    @temp_coordinates = Array.new

    while @player.ship_count < 4
      @ship = Ship.new
      puts "Place a [V]erticle or [H]orizontal ship?"
      vh = gets.strip.upcase

      if vh == "H"
        puts "Enter a center coordinate for your ship"
        get_coordinate()
        if horizontal_coordinates_available(@coordinate, @player.board)
          @temp_coordinates =  [@x+ ((@y-1).to_s), @coordinate, @x+ ((@y+1).to_s)]
        else
          print "That coordinate is taken, please select another coordinate. "
          place_player_ships()
        end

      elsif vh == "V"
        puts "Enter a center coordinate for your ship :"
        get_coordinate()
        if vertical_coordinates_available(@coordinate, @player.board)
          @temp_coordinates = [((@x.next).to_s)+ @y.to_s, @coordinate, (@x.chr.ord-1).chr + @y.to_s]
        else
          print "That coordinate is taken, please select another coordinate. "
          place_player_ships()
        end

      else
        puts "Not a valid option"
        place_player_ships()
      end

      @temp_coordinates.each do |coordinate|
        @player.board.coordinates.each do |space|
          if (space.xy == coordinate)
            space.has_ship = 1
            @ship.coordinates.push(space)
          end
        end
      end
      @player.add_ship(@ship)
      @player.board.draw_player_board
      @player.ship_count += 1
    end
  end


#selects computer ships
def place_computer_ships
    @temp_computer_coordinates = Array.new
    @temp_coord = @computer.board.coordinates.sample
    @x = @temp_coord.xy[0]
    @y = @temp_coord.xy[1].to_i
    @coordinate = @x + @y.to_s

    while @computer.ship_count <= 3
      if (@computer.ship_count % 2 == 0) && (horizontal_coordinates_available(@coordinate, @computer.board))
        @ship = Ship.new
        @computer.add_ship(@ship)
        @computer.ship_count += 1
        @temp_computer_coordinates = [@x+ ((@y-1).to_s), @xy, @x+ ((@y+1).to_s)]
        @temp_computer_coordinates.each do |coordinate|
          @computer.board.coordinates.each do |space|
            if (space.xy == coordinate)
              space.has_ship = 1
              @ship.coordinates.push(space)
            end
          end
        end
      elsif (@computer.ship_count % 2 == 1) && (vertical_coordinates_available(@coordinate, @computer.board))
        @ship = Ship.new
        @computer.add_ship(@ship)
        @computer.ship_count += 1
        @temp_computer_coordinates = [((@x.next).to_s)+ @y.to_s, @xy, (@x.chr.ord-1).chr + @y.to_s]
        @temp_computer_coordinates.each do |coordinate|
          @computer.board.coordinates.each do |space|
            if (space.xy == coordinate)
              space.has_ship = 1
              @ship.coordinates.push(space)
            end
          end
        end
      else
        place_computer_ships()
      end
    end
  end

  #checks if coordinates are available horizontally
  def horizontal_coordinates_available(xy, board)
    @xy = xy
    check_coordinates = [@x+ ((@y-1).to_s), @xy, @x+ ((@y+1).to_s)]
    coordinates_available = 0

    check_coordinates.each do |coordinate|
      board.coordinates.each do |space|
        if (space.xy == coordinate) && (space.has_ship == 0)
          coordinates_available += 1
        end
      end
    end

    if coordinates_available == 3
      return true
    else
      return false
    end
  end


  #checks if coordinates are available vertically
  def vertical_coordinates_available(xy, board)
    @xy = xy
    check_coordinates= [((@x.next).to_s)+ @y.to_s, @xy, (@x.chr.ord-1).chr + @y.to_s]
    coordinates_available = 0

    check_coordinates.each do |coordinate|
      board.coordinates.each do |space|
        if (space.xy == coordinate) && (space.has_ship == 0)
          coordinates_available += 1
        end
      end
    end

    if coordinates_available == 3
      return true
    else
      return false
    end
  end

  #checks for hit or miss
  def check_hit(target_coord, board)
    board = board
    target_coord = target_coord

    board.coordinates.each do |coordinate|
      if (coordinate.xy == target_coord) && (coordinate.has_ship == 1)
        coordinate.hit = 1
        puts "Hit!"
        if @current_player == @computer
          @player.board.draw_player_board()
        elsif @current_player == @player
          @computer.board.draw_computer_board()
        end
        print "\n"

      elsif (coordinate.xy == target_coord)
        coordinate.miss = 1
        puts "Miss!"
        if @current_player == @player
          @computer.board.draw_computer_board()
        elsif @current_player == @computer
          @player.board.draw_player_board()
        end

        print "\n"
      end
    end
  end

  #player selects coordinate to strike
  def player_turn
    @computer.board.draw_computer_board()
    puts "Your turn to fire. Select a new target coordinate! "
    target_coordinate = get_coordinate()
    puts "Firing . . ."
    countdown()
    check_hit(@coordinate, @computer.board)
    check_win(@computer)
    @current_player = @computer
  end

#computer selects random coordinate from available coordinates
  def computer_turn
    sleep 2
    puts "Computer is preparing to fire . . ."
    countdown()
    target_coordinate = @player.board.available_coordinates.sample.xy
    check_hit(target_coordinate, @player.board)
    check_win(@player)
    @current_player = @player
  end

  def countdown
    sleep 1
    print "\n"
    puts " . . ."
    print "\n"
    print "\n"
    sleep 1
    puts " . . ."
    print "\n"
    print "\n"
    sleep 1
  end

  def check_win(player) #need to test!!!!
    if player.check_all_ships() == true
      if player == @computer
        puts "You win"
        exit
      else
        puts "Computer wins"
        exit
      end
    end
  end

  def instructions
    print "Welcome to Battleship! Start new game [Y]/[N]? "
    start = gets.strip.to_s.upcase()
    if start == "Y"
      self.place_player_ships()

    elsif start == "N"
      exit
    else
      puts "Invalid entry. "
      instructions()
    end
  end


end

game = Game.new
game.instructions()
game.place_computer_ships()
while (game.player.check_all_ships == false) && (game.computer.check_all_ships == false)
  game.player_turn()
  sleep 1
  game.computer_turn()
  sleep 1
end



#NEXT TO WORK ON
#need method to quit game
#board spacing and turn timing
#need play again method
#refactor
#notify user that they can't fire at the same location twice
#notify if ship is sunk
#add tests
