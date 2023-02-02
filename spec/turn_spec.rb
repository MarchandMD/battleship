require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/turn'

RSpec.describe Turn do
  it 'exists' do
    human = Board.new
    ai = Board.new
    turn = Turn.new(human, ai)
    expect(turn).to be_a Turn
  end
  it 'has @human and @ai attributes' do
    human = Board.new
    ai = Board.new
    turn = Turn.new(human, ai)
    expect(turn.human).to eq(human)
    expect(turn.ai).to eq(ai)
  end
end
