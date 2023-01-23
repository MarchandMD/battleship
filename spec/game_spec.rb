require './lib/game'
require './lib/board'
require './lib/cell'

RSpec.describe Game do
  let(:game) { Game.new }

  context "#initialization" do
    it 'exists' do
      expect(game).to be_a Game
    end

    it 'has @computer_board' do
      expect(game.computer_board).to be_a Board
    end

    it 'has @player_board' do
      expect(game.player_board).to be_a Board
    end

    it 'has @player_cruiser' do
      expect(game.player_cruiser).to be_a Ship
    end

    it 'has @player_submarine' do
      expect(game.player_submarine).to be_a Ship
    end
    it 'has @computer_cruiser' do
      expect(game.computer_cruiser).to be_a Ship
    end

    it 'has @computer_submarine' do
      expect(game.computer_submarine).to be_a Ship
    end

    it 'has @player_cruiser_position' do
      expect(game.player_cruiser_position).to eq(nil)
    end
    it 'has @player_submarine_position' do
      expect(game.player_submarine_position).to eq(nil)
    end

    it 'has @computer_submarine_position' do
      expect(game.computer_submarine_position).to eq(nil)
    end
  end

  xit 'prints a welcome message' do
    expect { game.welcome_message }.to output.to_stdout
  end

  describe '#welcome_message' do
    xit 'prints a statement to the screen' do
      expect { game.welcome_message }.to output.to_stdout
    end
  end

  describe '#render_computer_board' do
    xit 'renders the computer board' do
      expect { game.render_computer_board }.to output.to_stdout
    end
  end

  describe '#render_player_board' do
    xit 'renders the player board' do
      expect { game.render_player_board }.to output.to_stdout
    end
  end

  describe '#place_computer_ships' do
    xit 'updates the @computer_cruiser_position' do
      expect(game.computer_cruiser_position).to eq(nil)
      game.place_computer_ships
      expect(game.computer_cruiser_position.length).to eq(3)
      expect(game.computer_submarine_position.length).to eq(2)
    end
  end

  describe '#place_player_ships' do
    xit 'asks for 3 squares for the Cruiser' do
      game.stub(:prompt_player_for_cruiser) { @player_cruiser_position = %w[A1 A2 A3] }
      expect(game.place_player_ships).to eq(true)
    end
  end

  describe '#start_turn' do
    it 'can start turn' do
    end
  end

  describe '#game_over?' do
    xit 'asks if the game is over' do
      expect { game.game_over? }.to be(false)
    end
  end

  describe '#game_over' do
    xit 'can declare game over' do
      expect { game.game_over }.to eq
    end
  end

  describe '#player_turn?' do
    xit "asks if player_turn yet" do
      expect { game.player_turn? }.to eq(true)
    end
  end

  describe '#player_makes_guess' do
    xit 'can prompt player to input guess' do
      expect { game.player_makes_guess }.to output.to_stdout
    end
  end

  describe '#computer_makes_guess' do
    xit 'initiates computer making guess' do
      expect { game.computer_makes_guess }.to output.to_stdout
    end
  end

  describe '#prompt_player_for_cruiser' do
    xit 'asks for cruiser coordinates' do
      expect { game.prompt_player_for_cruiser }.to output.to_stdout
    end
  end

  describe '#prompt_player_for_submarine' do
    xit 'asks for submarine coordinates' do
      expect { game.prompt_player_for_submarine }.to output.to_stdout
    end
  end

  describe '#show_both_boards' do
    xit 'renders both boards to stdout' do
      game.place_computer_ships
      expect { game.show_both_boards }.to output.to_stdout
    end
  end
end
