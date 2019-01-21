module Battleship
  # a ship
  class Ship
    SHIPS = {
      carrier:
        { size: 5, name: 'Carrier' },
      battleship:
        { size: 4, name: 'Battleship' },
      submarine:
        { size: 3, name: 'Submarine' },
      cruiser:
        { size: 3, name: 'Cruiser' },
      pt_boat:
        { size: 2, name: 'PT Boat' }
    }.freeze

    def self.ships
      SHIPS # may be configurable later
    end

    def self.ship_types
      ships.keys
    end

    def self.all
      ship_types.map { |type| Ship.new(type) }
    end

    attr_reader :type
    def initialize(type)
      raise InvalidShip unless Ship.ship_types.include? type

      @type = type
      @hits = 0
    end

    def name
      Ship.ships[@type][:name]
    end
    alias to_s name

    def size
      Ship.ships[@type][:size]
    end

    def hit!
      raise AlreadySunk if sunk?

      @hits += 1
      Battleship.message("You sank a #{name}") if sunk?
      sunk?
    end

    def sunk?
      @hits >= size
    end
  end
end
