require './lib/game'
require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class Game
  attr_reader :computer_board,
              :player_board,
              :player_turn,
              :player_cruiser,
              :player_cruiser_position,
              :player_submarine,
              :player_submarine_position,
              :computer_cruiser,
              :computer_submarine,
              :computer_submarine_position,
              :possible_player_guesses,
              :possible_computer_guesses,
              :total_player_health,
              :total_computer_health,
              :computer_guess,
              :player_guess

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @player_cruiser = Ship.new('Cruiser', 3)
    @player_cruiser_position = nil
    @player_submarine = Ship.new('Submarine', 2)
    @player_submarine_position = nil
    @computer_cruiser = Ship.new('Cruiser', 3)
    @computer_submarine = Ship.new('Submarine', 2)
    @computer_submarine_position = nil
    @possible_player_guesses = @computer_board.cells.keys
    @possible_computer_guesses = @player_board.cells.keys
    @player_turn = true
    @total_player_health = 5
    @total_computer_health = 5
    @computer_guess = nil
    @player_guess = nil
    @computer_shot_result = nil
    @player_shot_result = nil
  end

  def start
    welcome_message
    place_computer_ships
    place_player_ships
    game_loop
  end

  def computer_loses
    @computer_cruiser.health == 0 && @computer_submarine.health == 0
  end

  def player_loses
    @player_cruiser.health == 0 && @player_submarine.health == 0
  end

  def welcome_message
    puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit"

    input = gets.chomp.upcase
    evaluate_input_for_quit(input)

    until %w[P Q].include?(input)
      puts 'please only enter: p or q'
      input = gets.chomp.upcase
      exit if input == 'Q'
      # cool code goes here

    end
  end

  def render_computer_board
    @computer_board.render2
  end

  # unused method
  def show_computer_ships
    @computer_board.render2(true)
  end

  # makes the wrapped code more readable; does it though?
  def render_player_board
    @player_board.render2(true)
  end

  def place_computer_ships
    place_computer_cruiser
    place_computer_submarine
    puts "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long."
  end

  def place_computer_cruiser
    position = @computer_board.valid_cruiser_placement('computer')
    @computer_board.place_computer_ship(@computer_cruiser, position)
  end


  def place_computer_submarine
    valid_sub_positions = [%w[A1 A2], %w[A2 A3], %w[A3 A4], %w[B1 B2], %w[B2 B3], %w[B3 B4], %w[C1 C2], %w[C2 C3],
                           %w[C3 C4], %w[D1 D2], %w[D2 D3], %w[D3 D4], %w[A1 B1], %w[A2 B2], %w[A3 B3], %w[A4 B4], %w[B1 C1], %w[B2 C2], %w[B3 C3], %w[B4 C4], %w[C1 D1], %w[C2 D2], %w[C3 D3], %w[C4 D4]]

    @computer_submarine_position = valid_sub_positions.shuffle!.pop

    @computer_submarine_position = valid_sub_positions.shuffle!.pop until no_overlap
    @computer_board.place_computer_ship(@computer_submarine, @computer_submarine_position)
  end

  def no_overlap
    (@computer_board.computer_occupied_cells + @computer_submarine_position).uniq.length == (@computer_board.computer_occupied_cells + @computer_submarine_position).length
  end

  def place_player_ships
    prompt_player_for_cruiser
    @player_board.place(@player_cruiser, @player_cruiser_position)
    # @player_board.render2(true)
    prompt_player_for_submarine
    @player_board.place(@player_submarine, @player_submarine_position)
    # @player_board.render2(true)
  end

  def prompt_player_for_cruiser
    puts 'Enter the squares for the Cruiser (example - A1 A2 A3): '
    input = gets.chomp.upcase
    evaluate_input_for_quit(input)
    @player_cruiser_position = input.split(' ')
    until @player_board.valid_placement?(@player_cruiser, @player_cruiser_position)
      puts 'try again (example - A1 A2 A3):'
      input = gets.chomp.upcase
      evaluate_input_for_quit(input)
      @player_cruiser_position = input.split(' ')
    end
  end

  def prompt_player_for_submarine
    puts 'Enter the squares for the Submarine (example - B1 B2): '
    input = gets.chomp.upcase
    evaluate_input_for_quit(input)
    @player_submarine_position = input.split(' ')
    until @player_board.valid_placement?(@player_submarine, @player_submarine_position)
      puts 'try again (example - B1 B2):'
      input = gets.chomp.upcase
      evaluate_input_for_quit(input)
      @player_submarine_position = input.split(' ')
    end
  end

  def game_loop
    show_both_boards
    loop do
      if game_over?
        game_over
        break
      elsif @player_turn == true
        player_makes_guess
        @player_turn = false
      else
        computer_makes_guess
        show_both_boards
        output_shot_result
        @player_turn = true
      end
    end
  end

  def game_over?
    computer_loses || player_loses
  end

  def game_over
    if computer_loses
      puts 'You win!'
    else
      puts 'I win'
    end
    restart
  end

  def prompt_player_for_coordinate
    puts 'enter a cell to fire upon (example - A1): '
  end

  def player_makes_guess
    prompt_player_for_coordinate
    input = gets.chomp.upcase
    evaluate_input_for_quit(input)
    validate_input(input)

    @computer_board.cells[@player_guess].fire_upon
    remove_guess_from_possible_guesses

    determine_player_shot_result
  end

  def remove_guess_from_possible_guesses
    @possible_player_guesses.delete(@player_guess)
  end

  def determine_player_shot_result
    if computer_board.cells[@player_guess].render == 'H'
      @player_shot_result = 'H'
    elsif computer_board.cells[@player_guess].render == 'M'
      @player_shot_result = 'M'
    elsif computer_board.cells[@player_guess].render == 'X'
      @player_shot_result = 'X'
    end
  end

  def validate_input(input)
    until @possible_player_guesses.include?(input)
      puts 'Invalid Coordinate, please try again.'
      input = gets.chomp.upcase
      evaluate_input_for_quit(input)
    end
    @player_guess = input
  end

  def computer_makes_guess
    @possible_computer_guesses.shuffle!
    @computer_guess = @possible_computer_guesses.shift
    @player_board.cells[computer_guess].fire_upon
    determine_computer_shot_result
  end

  def determine_computer_shot_result
    if player_board.cells[@computer_guess].render == 'H'
      @computer_shot_result = 'H'
    elsif player_board.cells[@computer_guess].render == 'M'
      @computer_shot_result = 'M'
    elsif player_board.cells[@computer_guess].render == 'X'
      @computer_shot_result = 'X'
    end
  end

  def show_both_boards
    puts '========COMPUTER BOARD========'
    render_computer_board
    puts '========PLAYER BOARD========'
    render_player_board
  end

  def render_computer_output
    if @computer_shot_result == 'X'
      if computer_sunk_cruiser?
        puts 'I SUNK YOUR CRUISER!'
      elsif computer_sunk_sub?
        puts 'I SUNK YOUR SUB!'
      end
    elsif @computer_shot_result == 'H'
      puts "My shot on #{@computer_guess} was a hit."
    else
      puts "My shot on #{@computer_guess} was a miss."
    end
  end

  def render_player_output
    if @player_shot_result == 'X'
      if player_sunk_cruiser?
        puts 'YOU SUNK A CRUISER!'
      elsif player_sunk_sub?
        puts 'YOU SUNK A SUB!'
      end
    elsif @player_shot_result == 'H'
      puts "Your shot on #{@player_guess} was a hit."
    else
      puts "Your shot on #{@player_guess} was a miss."
    end
  end

  def output_shot_result
    render_player_output
    render_computer_output
  end

  # needs to be refactored to clear boards
  def restart
    welcome_message
    place_computer_ships
    place_player_ships
    game_loop
  end

  def player_sunk_cruiser?
    @computer_cruiser.health == 0
  end

  def player_sunk_sub?
    @computer_submarine.health == 0
  end

  def computer_sunk_cruiser?
    @player_cruiser.health == 0
  end

  def computer_sunk_sub?
    @player_submarine.health == 0
  end

  def evaluate_input_for_quit(input)
    exit if input == 'Q'
  end
end
