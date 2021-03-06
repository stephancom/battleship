require 'battleship/cell'
require 'battleship/coordinate'
require 'battleship/grid'
require 'battleship/player'
require 'battleship/ship'
require 'battleship/version'

module Battleship
  class CellOccupied < StandardError; end
  class AlreadyFired < StandardError; end
  class InvalidShip < StandardError; end
  class AlreadySunk < StandardError; end
  class OutOfRange < StandardError; end

  def self.message(text)
    # temporary until UI designed
    puts text
  end
end
