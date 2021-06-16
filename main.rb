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

clear_terminal
puts "Welcome to Tic Tack Toe"
puts "This game is designed for two human players"
puts ""
players = input_names
puts "Welcome #{players[0].name} and #{players[1].name}!"
players[0].choose_first_marker
puts "#{players[0].name} selected  #{players[0].marker}"

# if $PROGRAM_NAME == __FILE__
#   main
# end
