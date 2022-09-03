require './lib/game'
require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class Game
  attr_reader :computer_board,
              :player_board,
              :current_turn,
              :player_cruiser,
              :player_cruiser_position,
              :player_submarine,
              :player_submarine_position,
              :computer_cruiser,
              :computer_cruiser_position,
              :computer_submarine,
              :computer_submarine_position

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @current_turn = 'computer'
    @player_cruiser = Ship.new('Cruiser', 3)
    @player_cruiser_position = nil
    @player_submarine = Ship.new('Submarine', 2)
    @player_submarine_position = nil
    @computer_cruiser = Ship.new('Cruiser', 3)
    @computer_cruiser_position = nil
    @computer_submarine = Ship.new('Submarine', 2)
    @computer_submarine_position = nil
  end

  def start
    welcome_message
    place_computer_ships
    place_player_ships
    # game_loop
  end

  def welcome_message
    puts 'Welcome to BATTLESHIP'
    puts 'Enter p to play. Enter q to quit'
    input = gets.chomp.downcase
    until %w[p q].include?(input)
      puts 'please only enter: p or q'
      input = gets.chomp.downcase
    end
  end

  def render_computer_board
    @computer_board.render2
  end

  def show_computer_ships
    @computer_board.render2(true)
  end

  def render_player_board
    @player_board.render2
  end

  def show_player_board
    @player_board.render2(true)
  end

  def place_computer_ships
    # puts 'this is the computer board'
    place_computer_cruiser
    place_computer_submarine
    puts 'I have laid out my ships on the grid.'
    puts 'You now need to lay out your two ships.'
    puts 'The Cruiser is three units long and the Submarine is two units long.'
    render_player_board
  end

  def place_computer_cruiser
    @computer_cruiser_position = @computer_board.valid_cruiser_placement('computer')
    @computer_board.place_computer_ship(@computer_cruiser, @computer_cruiser_position)
  end

  def place_computer_submarine
    valid_sub_positions = [%w[A1 A2], %w[A2 A3], %w[A3 A4], %w[B1 B2], %w[B2 B3], %w[B3 B4], %w[C1 C2], %w[C2 C3],
                           %w[C3 C4], %w[D1 D2], %w[D2 D3], %w[D3 D4], %w[A1 B1], %w[A2 B2], %w[A3 B3], %w[A4 B4], %w[B1 C1], %w[B2 C2], %w[B3 C3], %w[B4 C4], %w[C1 D1], %w[C2 D2], %w[C3 D3], %w[C4 D4]]

    @computer_submarine_position = valid_sub_positions.shuffle!.pop

    @computer_submarine_position = valid_sub_positions.shuffle!.pop until no_overlap
    @computer_board.place_computer_ship(@computer_submarine, @computer_submarine_position)
  end

  def no_overlap
    (@computer_board.computer_occupied_cells + @computer_submarine_position).uniq.length == (@computer_board.computer_occupied_cells + @computer_submarine_position).length # this could just be 5  
  end

  def place_player_ships
    prompt_player_for_cruiser
    @player_board.place(@player_cruiser, @player_cruiser_position)
    @player_board.render2(true)
    prompt_player_for_submarine
    @player_board.place(@player_submarine, @player_submarine_position)
    @player_board.render2(true)
  end

  def prompt_player_for_cruiser
    puts 'Enter the squares for the Cruiser (example - A1 A2 A3): '
    input = gets.chomp.upcase
    @player_cruiser_position = input.split(' ')
    until @player_board.valid_placement?(@player_cruiser, @player_cruiser_position)
      puts 'try again  (example - A1 A2 A3):'
      input = gets.chomp.upcase
      @player_cruiser_position = input.split(' ')
    end
  end

  def prompt_player_for_submarine
    puts 'Enter the squares for the Submarine (example - B1 B2): '
    input = gets.chomp.upcase
    @player_submarine_position = input.split(' ')
    until @player_board.valid_placement?(@player_submarine, @player_submarine_position)
      puts 'try again  (example - B1 B2):'
      input = gets.chomp.upcase
      @player_submarine_position = input.split(' ')
    end
  end

  def game_loop
    loop do
      start_turn
      if game_over?
        game_over
        break
      elsif player_turn?
        player_makes_guess
        render_computer_board
        render_player_board
      else
        computer_makes_guess
        render_computer_board
        render_player_board
      end
    end
  end

  def game_over?; end

  def game_over; end
end
