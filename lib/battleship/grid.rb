require 'terminal-table'

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

    def place_ship_at(ship, coord, vertical)
      place_ship_at!(ship, coord, vertical)
      true
    rescue CellOccupied, OutOfRange
      false
    end

    def place_ship_at!(ship, coord, vertical)
      # range checking is implicit here...
      coords = if vertical
                 Array.new(ship.size) { |delta_row| Coordinate.new(coord.row + delta_row, coord.col) }
               else
                 Array.new(ship.size) { |delta_col| Coordinate.new(coord.row, coord.col + delta_col) }
               end
      raise CellOccupied if coords.any? { |c| self[c].occupied? } # check before placing so there's no half-placed ships

      coords.each do |c|
        self[c].place_ship(ship)
      end
    end

    def place_ship_randomly(ship)
      throw :foo if ship.nil?
      loop do
        break if place_ship_at(ship, Coordinate.random, [true, false].sample)
      end
    end

    def fire_at!(coord)
      self[coord].fire_on!
    end

    def to_table(title: nil, secret: false)
      char_method = secret ? :to_secret : :to_s
      Terminal::Table.new title: title do |t|
        t << [' '] + Coordinate::COLS
        @cells.each_with_index do |row, i|
          t << [i] + row.map(&char_method)
        end
      end
    end
  end
end
