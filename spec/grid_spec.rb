RSpec.describe Grid do
  describe 'creating a grid' do
    it 'should create 10x10=100 new Cells' do
      expect(Cell).to receive(:new).exactly(100).times
      Grid.new
    end
  end
  describe 'the grid' do
    let(:coords) { ('A'..'J').to_a.product((1..10).to_a).map(&:join).map { |str| Coordinate.from_string(str) } } # cartesian product FTW
    let(:grid) { Grid.new }
    let(:cells) { coords.map { |coord| grid[coord] } }

    it 'should contain Cells' do
      expect(cells).to all(be_an_instance_of(Cell))
    end

    it 'all cells should be empty' do
      expect(cells).not_to include(be_occupied)
    end

    it 'all cells should be unhit' do
      expect(cells).not_to include(be_hit)
    end
  end
  describe 'when placing a ship' do
    let(:ship) { Ship.new :submarine }
    let(:grid) { Grid.new }
    describe 'on an empty grid' do
      describe 'in bounds' do
        let(:start) { Coordinate.from_string('B2') }
        [true, false].each do |vertical|
          describe vertical ? 'vertically' : 'horizontally' do
            let(:other_coords) { vertical ? %w[B3 B4] : %w[C2 D2] }
            let(:coords_occupied) { [start] + other_coords.map { |c| Coordinate.from_string c } }
            describe 'place_ship_at!' do
              it 'should succeed' do
                expect {
                  grid.place_ship_at!(ship, start, vertical)
                }.not_to raise_exception
              end

              it 'should call place_ship on the cells' do
                coords_occupied.each do |c|
                  expect(grid[c]).to receive(:place_ship).with(ship).and_call_original
                end
                grid.place_ship_at!(ship, start, vertical)
              end

              it 'should fill in the right coordinates' do
                grid.place_ship_at!(ship, start, vertical)
                expect(coords_occupied.map { |c| grid[c] }).to all(be_occupied)
              end
            end
            describe 'place_ship_at' do
              it 'should return true' do
                expect(grid.place_ship_at(ship, start, vertical)).to be true
              end

              it 'should call place_ship_at!' do
                expect(grid).to receive(:place_ship_at!).with(ship, start, vertical).and_call_original
                grid.place_ship_at(ship, start, vertical)
              end
            end
          end
        end
      end

      describe 'out of bounds' do
        let(:start) { Coordinate.from_string('I9') }
        [true, false].each do |vertical|
          describe vertical ? 'vertically' : 'horizontally' do
            describe 'place_ship_at!' do
              it 'should fail' do
                expect {
                  grid.place_ship_at!(ship, start, vertical)
                }.to raise_exception(OutOfRange)
              end
            end
            describe 'place_ship_at' do
              it 'should return false' do
                expect(grid.place_ship_at(ship, start, vertical)).to be false
              end
            end
          end
        end
      end

      describe 'place_ship_randomly' do
        it 'should succeed' do
          expect {
            grid.place_ship_randomly(ship)
          }.not_to raise_exception
        end
      end
    end

    [true, false].each do |vertical|
      describe vertical ? 'vertically' : 'horizontally' do
        let(:start) { Coordinate.from_string('D3') }

        describe 'on a grid with other ships' do
          let(:three_cell) { Ship.new(:cruiser) }
          let(:four_cell) { Ship.new(:battleship) }
          describe 'a safe distance away' do
            before do
              # vertical cruiser far enough from horizontal sub
              grid.place_ship_at(three_cell, Coordinate.from_string('H2'), true)
              # horizontal battleship far enough from vertical sub
              grid.place_ship_at(four_cell, Coordinate.from_string('C7'), false)
            end

            describe 'place_ship_at!' do
              it 'should succeed' do
                expect {
                  grid.place_ship_at!(ship, start, vertical)
                }.not_to raise_exception
              end
            end
            describe 'place_ship_at' do
              it 'should return true' do
                expect(grid.place_ship_at(ship, start, vertical)).to be true
              end
            end
            describe 'place_ship_randomly' do
              it 'should succeed' do
                expect {
                  grid.place_ship_randomly(ship)
                }.not_to raise_exception
              end
            end
          end
          describe 'interfering with placement' do
            before do
              # vertical cruiser interferes with horizontal sub
              grid.place_ship_at!(three_cell, Coordinate.from_string('E2'), true)
              # horizontal battleship interferes with vertical sub
              grid.place_ship_at!(four_cell, Coordinate.from_string('C5'), false)
            end

            describe 'place_ship_at!' do
              it 'should fail' do
                expect {
                  grid.place_ship_at!(ship, start, vertical)
                }.to raise_exception CellOccupied
              end
            end
            describe 'place_ship_at' do
              it 'should return false' do
                expect(grid.place_ship_at(ship, start, vertical)).to be false
              end
            end
            describe 'place_ship_randomly' do
              it 'should succeed' do
                expect {
                  grid.place_ship_randomly(ship)
                }.not_to raise_exception
              end
            end
          end
        end
      end
    end
  end
end
