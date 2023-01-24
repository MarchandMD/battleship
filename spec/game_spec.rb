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

  describe '#welcome_message' do
    it 'prints a statement to the screen' do
      expect { game.welcome_message }.to output.to_stdout
    end
  end

  describe '#render_computer_board' do
    it 'renders the computer board' do
      expect { game.render_computer_board }.to output.to_stdout
    end
  end

  describe '#render_player_board' do
    it 'renders the player board' do
      expect { game.render_player_board }.to output.to_stdout
    end
  end

  describe '#place_computer_ships' do
    it 'updates the @computer_board.computer_occupied_cells' do
      expect(game.computer_board.computer_occupied_cells.length).to eq(0)
      game.place_computer_ships
      expect(game.computer_board.computer_occupied_cells.length).to eq(5)
    end
  end

  describe '#player_cruiser_prompt' do
    it 'gives player instructions for setting cruiser' do
      expect { game.player_cruiser_prompt }.to output.to_stdout
    end
  end

  describe '#player_cruiser_placement' do
    it 'updates @player_cruiser_position' do
      expect(game.player_cruiser_position).to eq(nil)
      game.player_cruiser_placement('A1 A2 A3')
      expect(game.player_cruiser_position).to eq(['A1', 'A2', 'A3'])
    end
  end

  describe '#start_turn' do
    it 'can start turn' do
    end
  end

  describe '#game_over?' do
    it 'asks if the game is over' do
      expect(game.game_over?).to be(false)
    end
  end

  describe '#player_cruiser_placement' do
    it 'asks for cruiser coordinates' do
      expect(game.player_cruiser_position).to eq(nil)
    end
  end
end
