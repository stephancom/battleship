module Battleship
  # represents a single player
  # intended to subclass as human/computer players
  class Player
    attr_reader :name
    attr_reader :grid
    attr_accessor :opponent
    def initialize(name)
      @name = name
      @grid = Grid.new
      @ships = Ship.all
      place_ships_randomly
    end

    def lost?
      @ships.all?(&:sunk?)
    end

    def won?
      @opponent&.lost?
    end

    def place_ships_randomly
      @ships.each do |ship|
        @grid.place_ship_randomly ship
      end
    end

    def fire_at!(coord)
      grid.fire_at!(coord)
    end

    def move!
      c = nil
      loop do
        c = Coordinate.random
        break unless opponent.grid[c].hit?
      end
      Battleship.message "#{name} fires at #{opponent.name} #{c}"
      opponent.fire_at!(c)
    end

    def visible_grid
      grid.to_table(title: name)
    end

    def opponent_grid
      opponent.visible_grid
    end
  end
end
