RSpec.describe Ship do
  it 'should fail on an invalid ship type' do
    expect {
      Ship.new :corvette
    }.to raise_error InvalidShip
  end

  Ship.ships.each_pair do |type, details|
    it "should create a #{details[:name]}" do
      expect { Ship.new type }.not_to raise_error
    end

    describe "a #{details[:name]}" do
      let(:ship) { Ship.new(type) }

      it "should be named #{details[:name]}" do
        expect(ship.name).to eq(details[:name])
      end

      it "should have size #{details[:size]}" do
        expect(ship.size).to eq(details[:size])
      end

      (0...details[:size]).each do |hits|
        describe "hit #{hits} time(s)" do
          before do
            hits.times do
              ship.hit!
            end
          end

          it 'should not be sunk' do
            expect(ship).not_to be_sunk
          end
        end
      end

      it 'should inform the player when it sinks' do
        (details[:size] - 1).times do
          ship.hit!
        end
        expect(Battleship).to receive(:message).with("You sank a #{details[:name]}")
        ship.hit!
      end

      describe "description hit #{details[:size]} times" do
        before do
          details[:size].times do
            ship.hit!
          end
        end

        it 'should be sunk' do
          expect(ship).to be_sunk
        end

        it 'should not be allowed to hit again' do
          expect { ship.hit! }.to raise_exception AlreadySunk
        end
      end
    end
  end
end
