# frozen_string_literal: true

require_relative "./color"

# Tracks the name and marker of the user
class User
  attr_accessor :marker
  attr_reader :name

  def initialize(name)
    @name = name
  end

  # Allows the players to choose their marker
  def choose_first_marker
    loop do
      print "#{@name} please choose '\e[1;36mX\e[0m' or '\e[1;31mO\e[0m': "
      marker = gets.chomp.downcase
      if marker == "x" || marker == "o"
        return @marker = marker == "x" ? "\e[1;36mX\e[0m" : "\e[1;31mO\e[0m"
      end
    end

  end
end
