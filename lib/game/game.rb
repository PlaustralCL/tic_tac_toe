# frozen_string_literal: true

require_relative "../utilities/color"
require_relative "./user"
require_relative "./board"

# Manages the overall game
class Game
  MARKER_CHOICES = ["\e[1;36mX\e[0m", "\e[1;31mO\e[0m"].freeze

  attr_accessor :players, :board, :turn

  # Randomly chooses 0 or 1
  def self.coin_flip
    rand(2)
  end

  # Clears the terminal
  def self.clear_terminal
    system("clear") || system("Cl's")
  end

  def initialize
    @board = Board.new
    @turn = 0
  end

  # Prompts for the users to enter their names. Returns an array of the user objects
  #
  # @return players [Array] User objects
  def input_names
    @players = []
    (1..2).each do |index|
      print "Player #{index}, what is your name? "
      name = gets.chomp
      @players[index - 1] = User.new(name)
    end
    @players
  end

  # Prompts players to enter their move. It checks to see if the choosen move is
  # valid. Loops until a valid move is selected
  #
  # @return [Hash] A hash containing the sub-array and element for the board grid.
  def choose_move
    move = ""
    loop do
      print "#{@players[@turn].name.bold_yellow}, please select a number (1-9) that is available for your turn: "
      move = gets.chomp.to_i
      break if (1..9).include?(move) && @board.valid_move?(move)

      puts "That is not a valid choice".red
    end
    move
  end

  # Updates the terminal at the beginning of the game and after each move
  def setup_terminal
    self.class.clear_terminal
    puts "Tic Tac Toe"
    @board.show_board
  end

  # Tracks playing up to 9 turns. Coordinates the helper functions.
  def play_game
    (0..8).each do |round_number|
      @turn = round_number % 2
      move = Board.translate_move(choose_move)

      @board.update_board(move[:sub_array], move[:element], @players[@turn].marker)

      setup_terminal
      break if %w[X O tie].include?(board.check_result)
    end
  end

  # Announces the result of the game
  def show_game_result
    if @board.check_result.downcase == @players[0].short_marker
      puts "#{@players[0].name.bold_yellow} is the winner!"
    elsif board.check_result.downcase == @players[1].short_marker
      puts "#{@players[0].name.bold_yellow} is the winner!"
    else
      puts "The game is a tie."
    end
  end

  # Ask if the players want to play again. The default value is yes. Anything
  # other than 'n' or 'N' will be considered a yes.
  def new_game?
    print "Do you want to play again? (Y/n) "
    user_choice = gets.chomp.downcase
    # return false if user_choice == n, otherwise is true
    (user_choice != "n")
  end
end
