require 'battleship/version'
require 'battleship/cell'
require 'battleship/ship'

module Battleship
  class CellOccupied < StandardError; end
  class AlreadyFired < StandardError; end
  class InvalidShip < StandardError; end
  class AlreadySunk < StandardError; end

  def self.message(text)
    # temporary until UI designed
    puts text
  end
end
