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

    def fire_on!
      raise AlreadyFired if hit?

      @hit = true
      @content.hit! if occupied?
      occupied?
    end

    def to_s
      return ' ' unless hit?
      return '.' unless occupied?
      return '*' unless @content.sunk?

      @content.name[0].upcase
    end

    def to_secret
      return to_s unless occupied?

      n = @content.name[0]
      hit? ? n.downcase : n.upcase
    end
  end
end
