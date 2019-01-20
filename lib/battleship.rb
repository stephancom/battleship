require 'battleship/version'
require 'battleship/cell'

module Battleship
  class CellOccupied < StandardError; end
  class AlreadyFired < StandardError; end
end
