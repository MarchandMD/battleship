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
  describe '#ai_ship_placement' do
    it 'can randomly place ships for the ai' do
      ai = Board.new
      human = Board.new
      turn = Turn.new(human, ai)
      expected = human.render2
      turn.ai_ship_placement
      expect(ai.render2(true)).not_to eq(expected)
    end
  end
end
