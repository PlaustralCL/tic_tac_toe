# frozen_string_literal: true

# Tracks the name and marker of the user
class User
  MARKER_CHOICES = ["\e[1;36mX\e[0m", "\e[1;31mO\e[0m"].freeze

  attr_accessor :marker, :short_marker
  attr_reader :name

  def initialize(name)
    @name = name
  end

  # Assigns a marker and the corresponding short marker to the first player.
  #
  # @param marker [String] The marker choosen by the first player, "x" or "o".
  def assign_first_marker(marker)
    @marker = marker == "x" ? MARKER_CHOICES[0] : MARKER_CHOICES[1]
    @short_marker = marker
  end

  # Assigns a marker and the corresponding short marker to the second player.
  # The second player gets the only remaining marker, no choice.
  #
  # @param used_marker [String] The marker assigned to the first player
  # @param short_marker [String] The short marker assigned to the first player
  def assign_second_marker(used_marker, short_marker)
    @marker = (MARKER_CHOICES - [used_marker]).join
    @short_marker = (%w[x o] - [short_marker]).join
  end
end
