# frozen_string_literal: true

class Board
  BOARD_TEMPLATE = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ].freeze

  def initialize
    @board = BOARD_TEMPLATE
  end

  # Updates the board array with the correct marker after a player's turn
  # @param sub_array [Integer] Identifies which sub array (0, 1, or 2) of @board
  #   will be updated
  # @param element [Integer] Element of sub_array that will be updated
  # @param marker [String] Marker that will be used in the square
  def update_board(sub_array, element, marker)
    @board[sub_array][element] = marker
  end

  # rubocop: disable Metrics/AbcSize
  def show_board
    puts ""
    puts " #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} "
    puts "---+---+---"
    puts " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} "
    puts "---+---+---"
    puts " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} "
  end

  def check_result
    # horizontal
    return horizontal_test unless horizontal_test == 'none'
    return vertical_test unless vertical_test == 'none'
  end


  def horizontal_test
    (0..2).each do |sub_array|
      test_array = @board[sub_array].join
      return 'X' if test_array == 'XXX'
      return 'O' if test_array == 'OOO'

      next
    end
    'none'
  end

  def vertical_test
    (0..2).each do |column|
      test_array = [@board[column][0], @board[column][1], @board[column][2]].join
      return 'X' if test_array == 'XXX'
      return 'O' if test_array == 'OOO'
    end
    'none'
  end

end


# Testing
if $PROGRAM_NAME == __FILE__
  def test_results(expect, actual, test_name)
    if expect == actual
      puts "#{test_name} passed"
    else
      puts "ERROR #{test_name} failed. Expected #{expect}, got #{actual}"
    end
  end
  # board1 = Board.new
  # puts 'X in upper right corner:'
  # board1.update_board(0, 2, 'X')
  # board1.show_board
  # puts ''

  # puts 'O in upper center:'
  # board1.update_board(1, 1, 'O')
  # board1.show_board

  # confirm no result

  # horizontal winner
  def test_horizontal_winner1
    # test with X
    board2 = Board.new
    (0..2).each do |element|
      board2.update_board(1, element, 'X')
    end
    expect = 'X'
    actual = board2.check_result
    test_results(expect, actual, __method__)
  end

  def test_horizontal_winner2
    # test with O
    board2 = Board.new
    (0..2).each do |element|
      board2.update_board(1, element, 'O')
    end
    expect = 'O'
    actual = board2.check_result
    test_results(expect, actual, __method__)
  end

  def test_vertical_winner
    board3 = Board.new
    (0..2).each do |row|
      board3.update_board(row, 2, "O")
    end
    expect = 'O'
    actual = board3.check_result
    test_results(expect, actual, __method__)
  end




  # vertical winner

  # diagonal winner

  # tie

  test_horizontal_winner1
  test_horizontal_winner2
  test_vertical_winner


end
