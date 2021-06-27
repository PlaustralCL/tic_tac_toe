# frozen_string_literal: true

require "pry"
require_relative "./lib/utilities/color"
require_relative "./lib/game/user"
require_relative "./lib/game/board"

MARKER_CHOICES = ["\e[1;36mX\e[0m", "\e[1;31mO\e[0m"].freeze

# Prompts for the users to enter their names. Returns an array of the user objects
# @return players [Array] User objects
def input_names
  players = []
  (1..2).each do |index|
    print "Player #{index}, what is your name? "
    name = gets.chomp
    players[index - 1] = User.new(name)
  end
  players
end

# Prompts players to enter their move. It checks to see if the choosen move is
# valid. Loops until a valid move is selected
#
# @param board [Object] The board object
# @param players [Array] The array tracking the user objects
# @param turn [Integer] An integer from 0 to 1 indicating which user from players
# gets to choose a move.
def choose_move(board, players, turn)
  move = ""
  loop do
    print "#{players[turn].name.bold}, please select a number (1-9) that is available for your turn: "
    move = gets.chomp.to_i
    break if (1..9).include?(move) && board.valid_move?(move)

    puts "That is not a valid choice".red
  end
  move
end

def setup_terminal(board)
  clear_terminal
  puts "Tic Tac Toe"
  board.show_board
end

# Tracks playing up to 9 turns. Coordinates the helper functions.
#
# @param board [Object]
# @param players [Array] Array containing the user objects
def play_game(board, players)
  (0..8).each do |round_number|
    turn = round_number % 2
    move = choose_move(board, players, turn)
    move = Board.translate_move(move)

    board.update_board(move[:sub_array], move[:element], players[turn].marker)

    setup_terminal(board)
    break if %w[X O tie].include?(board.check_result)
  end
end

# Announces the result of the game
#
# @param board [Object]
# @param players [Array] Array containing the user objects
def show_game_result(board, players)
  if board.check_result.downcase == players[0].short_marker
    puts "The winner is #{players[0].name}!"
  elsif board.check_result.downcase == players[1].short_marker
    puts "The winner is #{players[1].name}!"
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

def clear_terminal
  system("clear") || system("Cl's")
end

# Randomly chooses 0 or 1
def coin_flip
  rand(2)
end

# Welcome
clear_terminal
puts "Welcome to Tic Tac Toe"
puts "This game is designed for two human players"
puts ""

# Names
players = input_names
puts ""

# Choose markers
first_chooser = coin_flip
second_chooser = ([0, 1] - [first_chooser]).join.to_i
marker = ""
puts "Before we begin markers for the board need to be choosen. #{players[first_chooser].name} will go first."

# Input for first marker
loop do
  print "#{players[first_chooser].name.bold}, please choose '#{MARKER_CHOICES[0]}' or '#{MARKER_CHOICES[1]}': "
  marker = gets.chomp.downcase
  break if %w[x o].include?(marker)

  puts "That is not a valid choice".red
end

players[first_chooser].assign_first_marker(marker)

# The second player gets the only remaining marker, no choice
players[second_chooser].assign_second_marker(players[first_chooser].marker, players[first_chooser].short_marker)

# Announce the markers
puts ""
print "#{players[first_chooser].name} selected  #{players[first_chooser].marker}. "
puts "That means #{players[second_chooser].name} is #{players[second_chooser].marker}"
puts ""

# Play game
loop do
  # Determines who goes first
  first_chooser = coin_flip
  second_chooser = ([0, 1] - [first_chooser]).join.to_i
  players[0], players[1] = players[first_chooser], players[second_chooser]
  puts ""
  puts "I have flipped a coin, #{players[0].name.bold} will go first."
  print "Press `Enter` to continue "
  gets.chomp

  # set up and show initial board
  board = Board.new
  setup_terminal(board)

  play_game(board, players)
  show_game_result(board, players)
  break if new_game? == false
end

# if $PROGRAM_NAME == __FILE__
#   main
# end
