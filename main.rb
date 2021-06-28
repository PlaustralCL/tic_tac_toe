# frozen_string_literal: true

require "pry"
require_relative "./lib/utilities/color"
require_relative "./lib/game/user"
require_relative "./lib/game/board"
require_relative "./lib/game/game"

MARKER_CHOICES = ["\e[1;36mX\e[0m", "\e[1;31mO\e[0m"].freeze

# **** Main code ****
# Welcome
game = Game.new
Game.clear_terminal
puts "Welcome to Tic Tac Toe"
puts "This game is designed for two human players"
puts ""

# Names
game.input_names
puts ""

# Choose markers
first_chooser = Game.coin_flip
second_chooser = ([0, 1] - [first_chooser]).join.to_i
marker = ""
puts "Before we begin markers for the board need to be choosen. #{game.players[first_chooser].name} will go first."

# Input for first marker
loop do
  print "#{game.players[first_chooser].name.bold}, please choose '#{MARKER_CHOICES[0]}' or '#{MARKER_CHOICES[1]}': "
  marker = gets.chomp.downcase
  break if %w[x o].include?(marker)

  puts "That is not a valid choice".red
end

game.players[first_chooser].assign_first_marker(marker)

# The second player gets the only remaining marker, no choice
game.players[second_chooser].assign_second_marker(game.players[first_chooser].marker, game.players[first_chooser].short_marker)

# Announce the markers
puts ""
print "#{game.players[first_chooser].name} selected  #{game.players[first_chooser].marker}. "
puts "That means #{game.players[second_chooser].name} is #{game.players[second_chooser].marker}"
puts ""

# Play game. This will loop until the player says they do not
# want another game.
loop do
  # Determines who goes first
  first_chooser = Game.coin_flip
  second_chooser = ([0, 1] - [first_chooser]).join.to_i
  game.players[0], game.players[1] = game.players[first_chooser], game.players[second_chooser]
  puts ""
  puts "I have flipped a coin, #{game.players[0].name.bold} will go first."
  print "Press `Enter` to continue "
  gets.chomp

  # set up and show initial board
  game.setup_terminal
  # board = Board.new
  # setup_terminal(board)

  game.play_game
  # play_game(board, game.players)
  game.show_game_result
  # show_game_result(board, game.players)
  break if game.new_game? == false

  game.board.reset
end
