require './lib/cell'
require './lib/ship'
require 'spec_helper'

RSpec.describe Cell do
  it 'exists' do
    cell = Cell.new('B4')
    expect(cell).to be_a Cell
  end

  describe '#init' do
    # the 'cell' variable can be used in the 'it' blocks because the 'it' blocks are inside the describe block
    cell = Cell.new("B4")

    it 'is initialized with @coordinate instance variable' do
      expect(cell.coordinate).to be_a String
      expect(cell.coordinate).to eq("B4")
    end

    it 'is initialized with @ship instance variable' do
      expect(cell.ship).to eq(nil)
    end

    it 'is initialized with @fired_upon instance variable' do
      expect(cell.fired_upon).to eq(false)
    end
  end
  describe '#empty?' do
    it 'can check if a coordinate is empty' do
      cell = Cell.new("B4")
      expect(cell.empty?).to eq(true)
    end
  end
  describe '#place_ship' do
    it 'can place a ship and further tests the empty? method' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      cell.ship
      expect(cell.empty?).to eq(false)
    end
  end
  describe '#fired_upon?' do
    it 'can tell if cell fired upon before' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      expect(cell.fired_upon?).to eq(false)
    end
  end
  describe '#fire_upon' do
    it 'can decrease Ship health by one' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      expect(cell.fired_upon?).to eq(false)
      cell.fire_upon
      expect(cell.ship.health).to eq(2)
      expect(cell.fired_upon?).to eq(true)
    end
  end
end
