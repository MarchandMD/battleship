require './lib/game'
require './lib/board'
require './lib/cell'

class Game
  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @current_turn = 'computer' # either 'computer' or 'player'
  end

  def start
    welcome_message
    render_computer_board
    render_player_board
    # place_computer_ships
    # place_player_ships
    # game_loop
  end

  def welcome_message
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit"
    input = gets.chomp.downcase
    until input == 'p' || input == 'q'
      puts 'please only enter: p or q'
      input = gets.chomp.downcase
    end
  end

  def render_computer_board
    @computer_board.render2
  end

  def render_player_board
    @player_board.render2
  end

  def place_computer_ships; end

  def place_player_ships; end

  def game_loop
    loop do
      start_turn
      if game_over?
        game_over_method
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
end
