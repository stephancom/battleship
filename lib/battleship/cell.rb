module Battleship
  # a cell of a battleship
  class Cell
    def initialize
      @content = nil
      @hit = false
    end

    def occupied?
      !@content.nil?
    end

    def hit?
      @hit
    end

    def place_ship(ship)
      raise CellOccupied if occupied?
      raise InvalidShip unless ship.is_a? Ship

      @content = ship
    end

    def fire_on
      raise AlreadyFired if hit?

      @hit = true
      @content.hit! if occupied?
      occupied?
    end
  end
end
