# frozen_string_literal: true

# Track the status and update the tic tac toe board. Also has methods to
# check for  winning conditions.
class Board
  def initialize
    @grid =
      [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]
  end

  # Updates the board array with the correct marker after a player's turn
  # @param sub_array [Integer] Identifies which sub array (0, 1, or 2) of @grid
  #   will be updated
  # @param element [Integer] Element of sub_array that will be updated
  # @param marker [String] Marker that will be used in the square
  def update_board(sub_array, element, marker)
    @grid[sub_array][element] = marker
  end

  def board_status
    @grid
  end

  # Displays board onto the terminal
  # rubocop: disable Metrics/AbcSize
  def show_board
    puts ""
    puts " #{@grid[0][0]} | #{@grid[0][1]} | #{@grid[0][2]} "
    puts "---+---+---"
    puts " #{@grid[1][0]} | #{@grid[1][1]} | #{@grid[1][2]} "
    puts "---+---+---"
    puts " #{@grid[2][0]} | #{@grid[2][1]} | #{@grid[2][2]} "
  end

  # Checks for a winning result by testing each row, column, and diagonal
  def check_result
    # horizontal
    return check_horizontal unless check_horizontal == 'none'
    return check_vertical unless check_vertical == 'none'
    return check_diagonal1 unless check_diagonal1 == 'none'
    return check_diagonal2 unless check_diagonal2 == 'none'
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

  protected

  def check_horizontal
    (0..2).each do |sub_array|
      row = @grid[sub_array].join
      return 'X' if row == 'XXX'
      return 'O' if row == 'OOO'

      next
    end
    'none'
  end

  def check_vertical
    (0..2).each do |column|
      column_string = [@grid[0][column], @grid[1][column], @grid[2][column]].join
      return 'X' if column_string == 'XXX'
      return 'O' if column_string == 'OOO'
    end
    'none'
  end

  def check_diagonal1
    diagonal = [@grid[0][0], @grid[1][1], @grid[2][2]].join
    return 'X' if diagonal == 'XXX'
    return 'O' if diagonal == 'OOO'

    'none'
  end

  def check_diagonal2
    diagonal = [@grid[2][0], @grid[1][1], @grid[0][2]].join
    return 'X' if diagonal == 'XXX'
    return 'O' if diagonal == 'OOO'

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

  def test_new_board
    boarda = Board.new
    boarda.show_board
    boardb = Board.new
    boardb.show_board
  end

  def test_show_board
    board1 = Board.new
    puts 'X in upper right corner:'
    board1.update_board(0, 2, 'X')
    board1.show_board
    puts ''

    puts 'O in upper center:'
    board1.update_board(1, 1, 'O')
    board1.show_board
  end

  def test_horizontal_winner1
    # test with X
    board2 = Board.new
    (0..2).each do |element|
      board2.update_board(1, element, 'X')
    end
    expect = 'X'
    actual = board2.check_result
    board2.show_board
    test_results(expect, actual, __method__)
  end

  def test_horizontal_winner2
    # test with O
    board92 = Board.new
    (0..2).each do |element|
      board92.update_board(2, element, 'O')
    end
    expect = 'O'
    actual = board92.check_result
    board92.show_board
    test_results(expect, actual, __method__)
  end

  def test_vertical_winner
    board3 = Board.new
    (0..2).each do |row|
      board3.update_board(row, 2, 'O')
    end
    expect = 'O'
    actual = board3.check_result
    board3.show_board
    test_results(expect, actual, __method__)
  end

  def test_diagonal1
    board4 = Board.new
    (0..2).each do |element|
      board4.update_board(element, element, 'X')
    end
    expect = 'X'
    actual = board4.check_result
    board4.show_board
    test_results(expect, actual, __method__)
  end

  def test_diagonal2
    board5 = Board.new
    (0..2).each do |element|
      board5.update_board(element, 2 - element, 'X')
    end
    expect = 'X'
    actual = board5.check_result
    board5.show_board
    test_results(expect, actual, __method__)
  end

  def test_reset
    board6 = Board.new
    board6.update_board(1, 1, 'X')
    board6.show_board
    expect = Board.new
    expect.show_board
    expect = expect.board_status
    actual = board6.reset
    test_results(expect, actual, __method__)
  end

  # call test functions
  test_horizontal_winner1
  test_horizontal_winner2
  test_vertical_winner
  test_diagonal1
  test_diagonal2
  test_reset
end
