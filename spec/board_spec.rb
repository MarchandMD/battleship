require './lib/board'
require './lib/cell'
require './lib/ship'

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
    board = Board.new
    it 'can identify a valid coordinate' do
      expect(board.valid_coordinate?("A1")).to eq(true)
      expect(board.valid_coordinate?("A5")).to eq(false)
    end
  end

  describe '#valid_placement' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    it 'checks if ship length is correct when placing' do
      expect(board.valid_placement?(cruiser, ['A1', 'A2'])).to eq(false)
      expect(board.valid_placement?(submarine, ['A2', 'A3', 'A4'])).to eq(false)
      expect(board.valid_placement?(cruiser, ['A1', 'A2', 'A4'])).to eq(false)
      expect(board.valid_placement?(submarine, ['A1', 'C1'])).to eq(false)
      expect(board.valid_placement?(cruiser, ['A3','A2','A1'])).to eq(false)
      expect(board.valid_placement?(submarine, ['C1','B1'])).to eq(false)

    end
  end
end
