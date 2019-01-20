RSpec.describe Cell do
  let(:ship) { :some_ship } # TODO: ship model
  let(:cell) { Cell.new }

  describe 'initially' do
    it 'is empty' do
      expect(cell).not_to be_occupied
    end

    it 'has not been hit' do
      expect(cell).not_to be_hit
    end
  end

  describe 'when empty' do
    it 'can accept a ship' do
      expect {
        cell.place_ship ship
      }.not_to raise_exception
    end

    it 'is marked occupied when ship placed' do
      expect {
        cell.place_ship ship
      }.to change { cell.occupied? }.from(false).to(true)
    end

    pending 'can only be occupied by a ship'

    describe 'when fired upon' do
      it 'returns false' do
        expect(cell.fire_on).to be false
      end

      it 'marks itself hit' do
        expect {
          cell.fire_on
        }.to change { cell.hit? }.from(false).to(true)
      end
    end
  end

  describe 'when occupied' do
    let(:another_ship) { :second_ship }

    before do
      cell.place_ship ship
    end

    it 'is not empty' do
      expect(cell).to be_occupied
    end

    it 'cannot accept another ship' do
      expect {
        cell.place_ship another_ship
      }.to raise_exception(CellOccupied)
    end

    describe 'when fired upon' do
      it 'returns true' do
        expect(cell.fire_on).to be true
      end

      it 'marks itself hit' do
        expect {
          cell.fire_on
        }.to change { cell.hit? }.from(false).to(true)
      end

      pending 'it marks the ship hit'

      describe 'when it was already hit' do
        before do
          cell.fire_on
        end

        pending 'it does not mark the ship hit again'

        it 'cannot be fired upon again' do
          expect {
            cell.fire_on
          }.to raise_exception(AlreadyFired)
        end
      end
    end
  end
end
