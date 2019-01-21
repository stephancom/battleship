RSpec.describe Player do
  describe 'creating' do
    it 'should create the cells' do
      expect(Cell).to receive(:new).exactly(100).times.and_call_original
      Player.new('Akhbar')
    end

    it 'should create the ships' do
      expect(Ship).to receive(:new).exactly(5).times.and_call_original
      Player.new('Jeff')
    end
  end

  describe 'a new player' do
    let(:newb) { Player.new('Anakin') }

    it 'should have a name' do
      expect(newb.name).to eq('Anakin')
    end

    it 'should not have lost' do
      expect(newb).not_to be_lost
    end
  end

  describe 'two players in a game' do
    let(:alice) { Player.new('Alice') }
    let(:bob) { Player.new('Bob') }

    before do
      alice.opponent = bob
      bob.opponent = alice
    end

    describe 'when one has lost' do
      before do
        allow(bob).to receive(:lost?).and_return(true)
      end

      it 'the other has won' do
        expect(alice).to be_won
      end
    end

    describe 'when moving' do
      it 'prints a message' do
        expect(Battleship).to receive(:message)
        alice.move!
      end
      it 'fires on the other player' do
        expect(bob).to receive(:fire_at!)
        alice.move!
      end
    end

    describe '#opponent_grid' do
      it 'calls the opponent visible grid' do
        expect(bob.grid).to receive(:to_table).with(a_hash_including(title: 'Bob'))
        alice.opponent_grid
      end
    end
  end

  describe 'grid' do
    let(:player) { Player.new('Flynn') }

    it 'delegates #visible_grid to grid' do
      expect(player.grid).to receive(:to_table).with(a_hash_including(title: 'Flynn'))
      player.visible_grid
    end

    it 'returns a table object' do
      expect(player.visible_grid).to be_an_instance_of(Terminal::Table)
    end
  end

  describe 'when fired on' do
    let(:target) { Coordinate.from_string('E5') }
    let(:player) { Player.new('Custer') }
    it 'should delegate the hit to the grid' do
      expect(player.grid).to receive(:fire_at!).with(target)
      player.fire_at!(target)
    end
  end

end
