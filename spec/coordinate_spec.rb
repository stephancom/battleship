RSpec.describe Coordinate do
  good_coords = {
    'A1' => { row: 0, col: 0 },
    'B2' => { row: 1, col: 1 },
    'C3' => { row: 2, col: 2 },
    'D4' => { row: 3, col: 3 },
    'E5' => { row: 4, col: 4 },
    'F6' => { row: 5, col: 5 },
    'G7' => { row: 6, col: 6 },
    'H8' => { row: 7, col: 7 },
    'I9' => { row: 8, col: 8 },
    'J10' => { row: 9, col: 9 },
    'A5' => { row: 4, col: 0 },
    'A10' => { row: 9, col: 0 },
    'E1' => { row: 0, col: 4 },
    'E10' => { row: 9, col: 4 },
    'J1' => { row: 0, col: 9 },
    'J5' => { row: 4, col: 9 }
  }
  good_coords.each_pair do |str, rowcol|
    describe 'from string' do
      describe "Coordinate #{str}" do
        let(:coord) { Coordinate.from_string(str) }

        it "should have row #{rowcol[:row]}" do
          expect(coord.row).to be(rowcol[:row])
        end

        it "should have col #{rowcol[:col]}" do
          expect(coord.col).to be(rowcol[:col])
        end

        it "should turn to string as #{str}" do
          expect(coord.to_str).to eq(str)
        end
      end
    end

    describe 'from coordinates' do
      describe "Coordinates row: #{rowcol[:row]} col: #{rowcol[:col]}" do
        let(:coord) { Coordinate.new(rowcol[:row], rowcol[:col]) }

        it "should turn to string as #{str}" do
          expect(coord.to_str).to eq(str)
        end
      end
    end
  end

  %w[A0 A11 K0 K11 L88 1A 5C 9I].each do |failable|
    it "should fail to create for #{failable}" do
      expect {
        Coordinate.from_string(failable)
      }.to raise_error(OutOfRange)
    end
  end

  [[-1, 3], [8, -1], [0, 10], [11, 7]].each do |failpair|
    it "should fail to create at row: #{failpair.first} col: #{failpair.last}" do
      expect {
        Coordinate.new(failpair.first, failpair.last)
      }.to raise_error(OutOfRange)
    end
  end

  describe 'randomly generated' do  
    it 'should generate a random coordinate' do
      expect(Coordinate).to receive(:rand).twice.with(10).and_call_original
      Coordinate.random
    end

    it 'should generate a random coordinate A10' do
      expect(Coordinate).to receive(:rand).twice.with(10).and_return(9, 0)
      expect(Coordinate.random.to_str).to eq('A10')
    end

    it 'should generate a random coordinate D8' do
      expect(Coordinate).to receive(:rand).twice.with(10).and_return(7, 3)
      expect(Coordinate.random.to_str).to eq('D8')
    end

    it 'should generate a random coordinate J1' do
      expect(Coordinate).to receive(:rand).twice.with(10).and_return(0, 9)
      expect(Coordinate.random.to_str).to eq('J1')
    end
  end
end
