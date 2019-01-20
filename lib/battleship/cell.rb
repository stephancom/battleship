module Battleship
  # a cell of a battleship
  class Cell
    attr_reader :content
    attr_reader :hit
    def initialize
      @hit = false
    end

    def occupied?
      !@content.nil?
    end

    def hit?
      @hit
    end

    def place_ship(ship)
      # TODO: raise InvalidContent unless ship.is_a? Ship
      raise CellOccupied if occupied?

      @content = ship
    end

    def fire_on
      raise AlreadyFired if hit?

      @hit = true
      # mark hit on ship
      occupied?
    end
  end
end
