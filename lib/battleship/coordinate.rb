module Battleship
  # methods for working with coordinates eg A1, C4, J10
  class Coordinate
    SIZE = 10
    COLS = ('A'..'Z').to_a[0...SIZE].freeze
    ALPHA_TABLE = COLS.zip(0...SIZE).to_h.freeze
    COORD_REGEXP = /^(?<col>[#{COLS.join}])(?<row>\d{1,#{SIZE.to_s.length}})$/i.freeze
    raise OutOfRange if SIZE > 26 # maybe silly

    attr_reader :row
    attr_reader :col
    def initialize(row, col)
      @row = row
      @col = col
      raise OutOfRange unless in_range?
    end

    def self.from_string(str)
      axes = str.match(COORD_REGEXP)
      raise OutOfRange if axes.nil?

      col = ALPHA_TABLE[axes[:col].upcase]
      row = axes[:row].to_i - 1
      new(row, col)
    end

    def self.random
      new(rand(SIZE), rand(SIZE))
    end

    def to_s
      [COLS[@col], (@row + 1).to_s].join
    end

    def in_range?
      @row.between?(0, SIZE - 1) && @col.between?(0, SIZE - 1)
    end
  end
end
