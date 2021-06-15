# frozen_string_literal: true

require_relative "./color"
require_relative "./user"
require_relative "./board"

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




puts "Welcome to Tic Tack Toe"
puts "This game is designed for two human players"
puts ""
players = input_names
player1 = players[0]
player2 = players[1]
puts "Welcome #{player1.name} and #{player2.name}!"

# if $PROGRAM_NAME == __FILE__
#   main
# end
