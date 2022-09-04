require './lib/game'
require './lib/board'
require './lib/cell'

RSpec.describe Game do

  it 'exists' do
    game = Game.new
    expect(game).to be_a Game
  end

  it 'has attributes' do
    game = Game.new
    expect(game.computer_board).to be_a Board
    expect(game.player_board).to be_a Board
    expect(game.player_cruiser).to be_a Ship
    expect(game.player_submarine).to be_a Ship
    expect(game.player_cruiser_position).to eq(nil)
    expect(game.player_submarine_position).to eq(nil)
    expect(game.computer_cruiser).to be_a Ship
    expect(game.computer_submarine).to be_a Ship
    expect(game.computer_cruiser_position).to eq(nil)
    expect(game.computer_submarine_position).to eq(nil)
  end

  xit 'prints a welcome message' do
    game = Game.new
    expect { game.welcome_message }.to output.to_stdout
  end

  describe '#welcome_message' do
    xit 'prints a statement to the screen' do
      game = Game.new
      expect{game.welcome_message}.to output.to_stdout
    end
  end

  describe '#quit' do
    it 'can quit game at any time' do
      game = Game.new
      input = 'q'
      expect{game.quit}.to raise_error(SystemExit)
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
    it 'updates the @computer_cruiser_position' do
      game = Game.new
      expect(game.computer_cruiser_position).to eq(nil)
      game.place_computer_ships
      expect(game.computer_cruiser_position.length).to eq(3)
      expect(game.computer_submarine_position.length).to eq(2)
    end
  end

  describe '#place_player_ships' do
    xit 'asks for 3 squares for the Cruiser' do
      game = Game.new
      game.stub(:prompt_player_for_cruiser) {@player_cruiser_position = ['A1', 'A2', 'A3'] }
      expect(game.place_player_ships).to eq(true)
    end
  end

  describe '#start_turn' do
    it 'can start turn' do
      game = Game.new

    end
  end

  describe '#game_over?' do
    it 'asks if the game is over' do
      game = Game.new
      expect{game.game_over?}.to be(false)
    end
  end

  describe '#game_over' do
    it 'can declare game over' do
      game = Game.new
      expect{game.game_over}.to
    end
  end

  describe '#player_turn?' do
    it "asks if player_turn yet" do
      game = Game.new
      expect{game.player_turn?}.to
    end
  end

  describe '#player_makes_guess' do
    it 'can prompt player to input guess' do
      game = Game.new
      expect{game.player_makes_guess}.to
    end
  end

  describe '#computer_makes_guess' do
    it 'initiates computer making guess' do
      game = Game.new
      expect{game.computer_makes_guess}.to
    end
  end

  describe '#prompt_player_for_cruiser' do
    it 'asks for cruiser coordinates' do
      game = Game.new
      expect{game.prompt_player_for_cruiser}.to
    end
  end

  describe '#prompt_player_for_submarine' do
    it 'asks for swubmarine coordinates' do
      game = Game.new
      expect{game.prompt_player_for_submarine}.to
    end
  end

  describe '#show_both_boards' do
    it 'renders both boards to stdout' do
      game = Game.new
      game.place_computer_ships
      expect{ game.show_both_boards }.to output.to_stdout
    end
  end

end
