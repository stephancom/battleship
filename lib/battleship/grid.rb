module Battleship
  # the grid of cells
  class Grid
    SIZE = 10
    ALPHA_TABLE = ('A'..'Z').to_a[0...SIZE].zip(0...SIZE).to_h.freeze
    COORD_REGEXP = /^(?<col>[#{ALPHA_TABLE.keys.join}])(?<row>\d{1,#{(SIZE).to_s.length}})$/i
    raise OutOfRange if SIZE > 26 # maybe silly

    class << self
      def size
        SIZE # for debugging, mostly, or future configuration
      end

      def in_range?(row, col)
        row < size && col < size
      end
    end

    def initialize
      @cells = Array.new(SIZE) {
        Array.new(SIZE) { Cell.new }
      }
    end

    def cell_at_coord(coord)
      axes = coord.match(COORD_REGEXP)
      col = ALPHA_TABLE[axes[:col].upcase]
      row = axes[:row].to_i - 1
      self[row, col]
    end

    private

    def [](row, col)
      raise OutOfRange unless Grid.in_range?(row, col)

      @cells[row][col]
    end
  end
end
