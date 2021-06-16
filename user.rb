# frozen_string_literal: true

require_relative "./color"

# Tracks the name and marker of the user
class User
  MARKER_CHOICES = ["\e[1;36mX\e[0m", "\e[1;31mO\e[0m"].freeze

  attr_accessor :marker
  attr_reader :name

  def initialize(name)
    @name = name
  end

  # Allows the players to choose their marker
  def choose_first_marker
    loop do
      print "#{@name} please choose '#{MARKER_CHOICES[0]}' or '#{MARKER_CHOICES[1]}': "
      marker = gets.chomp.downcase
      if %w[x y].include?(marker)
        return @marker = marker == "x" ? MARKER_CHOICES[0] : MARKER_CHOICES[1]
      end
    end

  end
end
