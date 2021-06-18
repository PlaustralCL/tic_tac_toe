# frozen_string_literal: true

require_relative "./color"
require_relative "./user"
require_relative "./board"

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



def clear_terminal
  system("clear") || system("cls")
end

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
puts "Before we begin markers for the board need to be choosen. #{players[first_chooser].name} will go first."
players[first_chooser].choose_first_marker
players[second_chooser].marker = (MARKER_CHOICES - [players[first_chooser].marker]).join
print "#{players[first_chooser].name} selected  #{players[first_chooser].marker}. "
puts "That means #{players[second_chooser].name} is #{players[second_chooser].marker}"
print "Press `Enter` to continue "
gets.chomp

# Play game

# Determines who goes first
first_chooser = coin_flip
second_chooser = ([0, 1] - [first_chooser]).join.to_i
players[0], players[1] = players[first_chooser], players[second_chooser]

# set up and show initial board
clear_terminal
board = Board.new
board.show_board
result = "none"

# Choose moves
(0..8).each do |round_number|
  turn = round_number % 2.0 == 0.0 ? 0 : 1
  print "#{players[turn].name} please select a number for your move: "
  move = gets.chomp.to_i
  move = Board.translate_move(move)

  board.update_board(move[:sub_array], move[:element], players[turn].marker)

  clear_terminal
  board.show_board
  result = board.check_result
  p result
  gets
  break if %w[X O tie].include?(result)
end

puts "The winner is #{result}"






# if $PROGRAM_NAME == __FILE__
#   main
# end
