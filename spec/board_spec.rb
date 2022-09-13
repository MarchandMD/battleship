¡require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

RSpec.describe Board do
  it 'exists' do
    board = Board.new
    expect(board).to be_a Board
  end

  it 'has @cells to start' do
    board = Board.new
    expect(board.cells).to be_a Hash
    expect(board.cells.keys.length).to eq(16)
    expect(board.cells.values.length).to eq(16)
    expect(board.cells['A1']).to be_a Cell
  end

  describe '#valid_coordinate?' do
    it 'can identify a valid coordinate' do
      board = Board.new
      expect(board.valid_coordinate?('A1')).to eq(true)
      expect(board.valid_coordinate?('A5')).to eq(false)
    end
  end


  describe '#valid_placement?' do
    it 'checks if ship length is correct when placing' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)
      expect(board.valid_placement?(cruiser, %w[A1 A2])).to eq(false)
      expect(board.valid_placement?(submarine, %w[A2 A3 A4])).to eq(false)
    end

    it "doesn't allow diagonal placement of ships" do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)
      expect(board.valid_placement?(cruiser, %w[A1 B2 C3])).to be false
      expect(board.valid_placement?(submarine, %w[C2 D3])).to be false
      expect(board.valid_placement?(cruiser, %w[B2 C3 D4])).to eq(false)
    end

    it 'can make sure ships are not overlapping' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      board.place(cruiser, %w[A1 A2 A3])
      submarine = Ship.new('Submarine', 2)
      expect(board.valid_placement?(submarine, %w[A1 B1])).to eq(false)
    end

    it 'can determine if a placement is valid' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)
      expect(board.valid_placement?(submarine, %w[A1 B1])).to eq(true)
    end
  end

  describe '#place' do
    it 'can place a ship on multiple cells' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      board.place(cruiser, %w[A1 A2 A3])
      cell_1 = board.cells['A1']
      cell_2 = board.cells['A2']
      cell_3 = board.cells['A3']
      cell_1.ship
      cell_2.ship
      expect(cell_3.ship).to be_a Ship
      expect(cell_3.ship == cell_2.ship).to eq(true)
    end
  end

  describe '#render2' do
    it 'can render the board with dots' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      board.place(cruiser, %w[A1 A2 A3])
      expect(board.cells['A1']).to be_a Cell
      expect(board.cells['A1'].render).to eq('.')
      expect { board.render2 }.to output("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n").to_stdout
    end

    it 'can reveal the ships' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      board.place(cruiser, %w[A1 A2 A3])
      expect(board.cells['A1']).to be_a Cell
      expect { board.render2(true) }.to output("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n").to_stdout

    end
  end

  describe '#valid_cruiser_placement' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)

    it 'can determine if cruiser placement is valid' do
      expect(board.valid_cruiser_placement(%w[A1 A2 A3])).to eq(true)
    end
    it 'can determine if cruiser placement is not valid' do
      expect(board.valid_cruiser_placement(%w[A1 A2 B3])).to be false
    end

  end
  describe '#valid_submarine_placement' do
    board = Board.new
    submarine = Ship.new('Cruiser', 2)

    it 'can determine if submarine placement is valid' do
      expect(board.valid_submarine_placement(%w[A1 A2])).to eq(true)
    end
    it 'can determine if submarine placement is not valid' do
      expect(board.valid_submarine_placement(%w[A1 C2])).to be false
    end

  end

  describe '#occupied_cells' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, %w[A1 A2 A3])
    submarine = Ship.new('Submarine', 2)
    it 'has a list of occupied cells' do
      expect(board.occupied_cells).to eq(%w[A1 A2 A3])
    end

  end
end
