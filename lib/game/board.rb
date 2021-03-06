# frozen_string_literal: true

require_relative "../utilities/color"

# Track the status and update the tic tac toe board. Also has methods to
# check for  winning conditions.
# X = "\e[1;36mX\e[0m"
# O = "\e[1;31mO\e[0m"
class Board
  # Translates the integer move selected by the player into the sub array and
  # element of the grid array.
  #
  # @param move [Integer] A number from 1 - 9
  # @return [Hash] Hash with the sub_array and element
  def self.translate_move(move)
    decoder = {
      1 => { sub_array: 0, element: 0 },
      2 => { sub_array: 0, element: 1 },
      3 => { sub_array: 0, element: 2 },
      4 => { sub_array: 1, element: 0 },
      5 => { sub_array: 1, element: 1 },
      6 => { sub_array: 1, element: 2 },
      7 => { sub_array: 2, element: 0 },
      8 => { sub_array: 2, element: 1 },
      9 => { sub_array: 2, element: 2 }
    }
    decoder[move]
  end

  def initialize
    @grid =
      [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]
  end

  # Updates the board array with the correct marker after a player's turn
  #
  # @param sub_array [Integer] Identifies which sub array (0, 1, or 2) of @grid
  #   will be updated
  # @param element [Integer] Element of sub_array that will be updated
  # @param marker [String] Marker that will be used in the square
  def update_board(sub_array, element, marker)
    @grid[sub_array][element] = marker
  end

  # Validate if the move choosen (1-9) is available
  #
  # @param move [Integer] An integer between 1 and 9
  # @return [Boolean] True if the move is valid, otherwise false
  def valid_move?(move)
    remaining_moves = @grid.flatten.each_with_object([]) do |item, array|
      array.push(item) if item.instance_of?(Integer)
    end
    remaining_moves.include?(move)
  end

  def board_status
    @grid
  end

  # Displays board onto the terminal
  # rubocop: disable Metrics/AbcSize
  def show_board
    puts ""
    puts "       #{@grid[0][0]} | #{@grid[0][1]} | #{@grid[0][2]} "
    puts "      ---+---+---"
    puts "       #{@grid[1][0]} | #{@grid[1][1]} | #{@grid[1][2]} "
    puts "      ---+---+---"
    puts "       #{@grid[2][0]} | #{@grid[2][1]} | #{@grid[2][2]} "
    puts ""
  end

  # Resets the board back to the starting configuration
  def reset
    @grid =
      [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]
    @grid
  end

  # Checks for a winning result by testing each row, column, and diagonal. This
  # relies on the protected methods to check for multiple possible winning
  # conditions.
  #
  # @return [String] A string representing the winning side: "X", "Y", "tie", "none"
  def check_result
    # horizontal
    return check_horizontal unless check_horizontal == "none"
    return check_vertical unless check_vertical == "none"
    return check_diagonal1 unless check_diagonal1 == "none"
    return check_diagonal2 unless check_diagonal2 == "none"
    return check_tie unless check_tie == "none"

    # default return value if no winner or tie  is found
    "none"
  end

  protected

  def check_horizontal
    (0..2).each do |sub_array|
      row = @grid[sub_array].join
      return "X" if row == "\e[1;36mX\e[0m\e[1;36mX\e[0m\e[1;36mX\e[0m"
      return "O" if row == "\e[1;31mO\e[0m\e[1;31mO\e[0m\e[1;31mO\e[0m"

      next
    end
    "none"
  end

  def check_vertical
    (0..2).each do |column|
      column_string = [@grid[0][column], @grid[1][column], @grid[2][column]].join
      return "X" if column_string == "\e[1;36mX\e[0m\e[1;36mX\e[0m\e[1;36mX\e[0m"
      return "O" if column_string == "\e[1;31mO\e[0m\e[1;31mO\e[0m\e[1;31mO\e[0m"
    end
    "none"
  end

  def check_diagonal1
    diagonal = [@grid[0][0], @grid[1][1], @grid[2][2]].join
    return "X" if diagonal == "\e[1;36mX\e[0m\e[1;36mX\e[0m\e[1;36mX\e[0m"
    return "O" if diagonal == "\e[1;31mO\e[0m\e[1;31mO\e[0m\e[1;31mO\e[0m"

    "none"
  end

  def check_diagonal2
    diagonal = [@grid[2][0], @grid[1][1], @grid[0][2]].join
    return "X" if diagonal == "\e[1;36mX\e[0m\e[1;36mX\e[0m\e[1;36mX\e[0m"
    return "O" if diagonal == "\e[1;31mO\e[0m\e[1;31mO\e[0m\e[1;31mO\e[0m"

    "none"
  end

  def check_tie
    @grid.flatten.each do |element|
      return "none" if element.instance_of?(Integer)
    end
    "tie"
  end
end

# Testing
if $PROGRAM_NAME == __FILE__
  def test_results(expect, actual, test_name)
    if expect == actual
      puts "#{test_name} #{'passed'.green}"
    else
      puts "#{'ERROR'.red} #{test_name} failed. Expected #{expect}, got #{actual}"
    end
  end

  def test_new_board
    boarda = Board.new
    boarda.show_board
    boardb = Board.new
    boardb.show_board
  end

  def test_show_board
    board1 = Board.new
    puts "X in upper right corner:"
    board1.update_board(0, 2, "\e[1;36mX\e[0m")
    board1.show_board
    puts ""

    puts "O in upper center:"
    board1.update_board(1, 1, "\e[1;31mO\e[0m")
    board1.show_board
  end

  test_new_board
  test_show_board
end
