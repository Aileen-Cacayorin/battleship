load 'coordinate.rb'
load 'ship.rb'
load 'board.rb'


class Player
  attr_accessor :ships, :ship_count, :board

  def initialize
    @ships = Array.new
    @ship_count = 0
    @board = Board.new
  end

  def add_ship(ship)
    @ships.push(ship)
  end

  def check_all_ships
    self.ships.each do |ship|
      if ship.check_sink == false
        return false
      else
        next
      end
    end
    return true
  end
end
