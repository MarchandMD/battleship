require './lib/cell'
require './lib/ship'
require 'spec_helper'

RSpec.describe Cell do
  it 'exists' do
    cell = Cell.new('B4')
    expect(cell).to be_a Cell
  end

  describe '#init' do
    cell = Cell.new('B4')

    it 'is initialized with @coordinate instance variable' do
      expect(cell.coordinate).to be_a String
      expect(cell.coordinate).to eq('B4')
    end

    it 'is initialized with @ship instance variable nil by default' do
      expect(cell.ship).to eq(nil)
    end

    it 'is initialized with @fired_upon instance variable' do
      expect(cell.fired_upon).to eq(false)
    end
  end
  describe '#empty?' do
    it 'can check if a coordinate is empty' do
      cell = Cell.new('B4')
      expect(cell.empty?).to eq(true)
    end
  end
  describe '#place_ship' do
    cell = Cell.new('B4')
    cruiser = Ship.new('Cruiser', 3)

    it 'can place a ship and further tests the empty? method' do
      cell.place_ship(cruiser)
      cell.ship
      expect(cell.empty?).to eq(false)
    end

    it 'places a ship in a Cell' do
      expect(cell.ship).to be_a Ship
    end
  end
  describe '#fired_upon?' do
    it 'can tell if cell fired upon before' do
      cell = Cell.new('B4')
      cruiser = Ship.new('Cruiser', 3)
      cell.place_ship(cruiser)
      expect(cell.fired_upon?).to eq(false)
    end
  end
  describe '#fire_upon' do
    it 'can decrease Ship health by one' do
      cell = Cell.new('B4')
      cruiser = Ship.new('Cruiser', 3)
      cell.place_ship(cruiser)
      expect(cell.fired_upon?).to eq(false)
      cell.fire_upon
      expect(cell.ship.health).to eq(2)
      expect(cell.fired_upon?).to eq(true)
    end
  end
  describe '#render' do
    it 'renders basic actions' do
      cell_1 = Cell.new('B4')
      expect(cell_1.render).to eq('.')
      cell_1.fire_upon
      expect(cell_1.render).to eq('M')
    end
    it 'renders more complex actions' do
      cell_2 = Cell.new('C3')
      cruiser = Ship.new('Cruiser', 3)
      cell_2.place_ship(cruiser)
      expect(cell_2.render(true)).to eq('S')
      cell_2.fire_upon
      expect(cell_2.render).to eq('H')
      expect(cruiser.sunk?).to eq(false)
      cruiser.hit
      cruiser.hit
      expect(cruiser.sunk?).to eq(true)
      expect(cell_2.render).to eq('X')
    end
  end
end
