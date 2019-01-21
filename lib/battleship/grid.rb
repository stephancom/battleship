require_relative 'grid'
module Battleship
  # the grid of cells
  class Grid
    SIZE = Coordinate::SIZE

    def initialize
      @cells = Array.new(SIZE) { Array.new(SIZE) { Cell.new } }
    end

    def [](coord)
      @cells[coord.row][coord.col]
    end
  end
end
