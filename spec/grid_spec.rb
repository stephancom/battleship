RSpec.describe Grid do
  describe 'creating a grid' do
    it 'should create 10x10=100 new Cells' do
      expect(Cell).to receive(:new).exactly(100).times
      Grid.new
    end
  end
  describe 'the grid' do
    let(:coords) { ('A'..'J').to_a.product((1..10).to_a).map(&:join).map { |str| Coordinate.new_from_string(str) } } # cartesian product FTW
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
end
