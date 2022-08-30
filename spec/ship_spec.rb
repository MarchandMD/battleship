require './lib/ship'
require 'spec_helper'

RSpec.describe Ship do
  it 'exists' do
    cruiser = Ship.new('Cruiser', 3)
    expect(cruiser).to be_an_instance_of(Ship)
  end

  describe '#init' do
    cruiser = Ship.new('Cruiser', 3)
    it 'has readable attribute @name' do
      expect(cruiser.name).to eq('Cruiser')
    end
    it 'has readable attribute @length' do
      expect(cruiser.length).to eq(3)
    end
    it 'has readable attribute @health' do
      expect(cruiser.health).to eq(3)
    end
  end

  describe '#sunk?' do
    it 'decides if ship has sunk' do
      cruiser = Ship.new('Cruiser', 3)
      expect(cruiser.sunk?).to eq(false)
    end
  end

  describe '#hit' do
    it 'decreases @health by 1 point' do
      cruiser = Ship.new('Cruiser', 3)
      cruiser.hit
      expect(cruiser.health).to eq 2
    end
  end
end
