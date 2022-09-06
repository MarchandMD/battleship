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
              :computer_cruiser_position,
              :computer_submarine,
              :computer_submarine_position,
              :possible_player_guesses,
              :possible_computer_guesses,
              :total_player_health,
              :total_computer_health,
              :computer_guess

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @player_cruiser = Ship.new('Cruiser', 3)
    @player_cruiser_position = nil
    @player_submarine = Ship.new('Submarine', 2)
    @player_submarine_position = nil
    @computer_cruiser = Ship.new('Cruiser', 3)
    @computer_cruiser_position = nil
    @computer_submarine = Ship.new('Submarine', 2)
    @computer_submarine_position = nil
    @possible_player_guesses = %w[A1 A2 A3 A4 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4]
    @possible_computer_guesses = %w[A1 A2 A3 A4 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4]
    @player_turn = true
    @total_player_health = 5
    @total_computer_health = 5
    @computer_guess = nil
  end

  def computer_loses
    @computer_cruiser.health == 0 && @computer_submarine.health == 0
  end

  def player_loses
    @player_cruiser.health == 0 && @player_submarine.health == 0
  end

  def start
    welcome_message
    place_computer_ships
    place_player_ships
    game_loop
  end

  def welcome_message
    puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit"
    input = gets.chomp.downcase
    until %w[p q].include?(input)
      puts 'please only enter: p or q'
      input = gets.chomp.downcase
        #cool code goes here
    end
    if input == 'q'
      quit
    end
  end

  def quit
    exit!
  end

  def render_computer_board
    @computer_board.render2
  end

  def show_computer_ships
    @computer_board.render2(true)
  end

  def render_player_board
    @player_board.render2(true)
  end

  def show_player_board
    @player_board.render2(true)
  end

  def place_computer_ships
    # puts 'this is the computer board'
    place_computer_cruiser
    place_computer_submarine
    puts "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long."
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
      puts 'try again (example - A1 A2 A3):'
      input = gets.chomp.upcase
      @player_cruiser_position = input.split(' ')
    end
  end

  def prompt_player_for_submarine
    puts 'Enter the squares for the Submarine (example - B1 B2): '
    input = gets.chomp.upcase
    @player_submarine_position = input.split(' ')
    until @player_board.valid_placement?(@player_submarine, @player_submarine_position)
      puts 'try again (example - B1 B2):'
      input = gets.chomp.upcase
      @player_submarine_position = input.split(' ')
    end
  end

  def game_loop
    loop do
      show_both_boards
      if game_over?
        game_over
        break
      elsif @player_turn == true
        player_makes_guess
        @player_turn = false
      else
        computer_makes_guess
        @player_turn = true
      end
    end
  end


  def game_over?
    computer_loses || player_loses
   #  @total_computer_health == 0 || @total_player_health == 0

    # hp_coords = []
    # hp_coords << player_cruiser_position
    # hp_coords << player_submarine_position
    # hp_coords.each do |hp|
    #   total_hp += hp.cell.ship.health
    # end
    # total_hp == 0
  end


  def game_over
    if computer_loses
     puts 'You win!'
      welcome_message
    else
      puts 'I win'
      welcome_message
    end
  end

  def player_makes_guess
    puts "enter a cell to fire upon (example - A1): "
    input = gets.chomp.upcase
    until @possible_player_guesses.include?(input)
      puts 'Invalid Coordinate, please try again.'
      input = gets.chomp.upcase
    end
    @computer_board.cells[input].fire_upon
    @possible_player_guesses.delete(input)
  end

  def computer_makes_guess
    @possible_computer_guesses.shuffle!
    @computer_guess = (@possible_computer_guesses.shift)
    render_computer_output
    @player_board.cells[computer_guess].fire_upon
  end

  def show_both_boards
    puts "========COMPUTER BOARD========"
    render_computer_board
    puts "========PLAYER BOARD========"
    render_player_board
  end

  def render_computer_output
    if false
      puts "YOU SUNK A BOAT"
    elsif 1 == 2
      puts "My shot on #{computer_guess} was a hit."
    else
      puts "My shot on #{computer_guess} was a miss."
    end
  end

  def render_player_output
    if false
      puts "YOU SUNK A BOAT"
    elsif 1 == 2
      puts "Your shot on #{computer_guess} was a hit."
    else
      puts "Your shot on #{computer_guess} was a miss."
    end
  end

end
