require './lib/game'
require './lib/board'
require './lib/cell'

RSpec.describe Game do


  it 'exists' do
    game = Game.new
    expect(game).to be_a Game
  end

  it 'has attributes' do
  end

  it 'prints a welcome message' do
    game = Game.new
    expect { game.start }.to output.to_stdout
  end

  describe '#welcome_message' do
    it 'prints a statement to the screen' do
      game = Game.new
      expect{game.welcome_message}.to output.to_stdout
    end
  end

  describe '#render_computer_board' do
    it 'renders the computer board' do
      game = Game.new
      expect{game.render_computer_board}.to output.to_stdout
    end
  end

  describe '#render_player_board' do
    it 'renders the player board' do
      game = Game.new
      expect{game.render_player_board}.to output.to_stdout
    end
  end

  describe '#place_computer_ships' do
  end

  describe '#place_player_ships' do
    it 'asks for 3 squares for the Cruiser' do
    end
  end

  describe '#start_turn' do
  end

  describe '#game_over?' do
  end

  describe '#game_over' do
  end

  describe '#player_turn?' do
  end

  describe '#player_makes_guess' do
  end

  describe '#computer_makes_guess' do
  end

  describe '#prompt_player_for_cruiser' do
    it 'asks for cruiser coordinates' do
    end
  end

end