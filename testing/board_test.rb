# frozen_string_literal: true

require_relative "./test"
require_relative "../board"

# Testing for board.rb
class BoardTest < Test
  def xtest_new_board
    boarda = Board.new
    boarda.show_board
    boardb = Board.new
    boardb.show_board
  end

  def xtest_show_board
    board1 = Board.new
    puts "X in upper right corner:"
    board1.update_board(0, 2, "\e[1;36mX\e[0m")
    board1.show_board
    puts ""

    puts "O in upper center:"
    board1.update_board(1, 1, "\e[1;31mO\e[0m")
    board1.show_board
  end

  def test_horizontal_winner1
    # test with X
    board2 = Board.new
    (0..2).each do |element|
      board2.update_board(1, element, "\e[1;36mX\e[0m")
    end
    expect = "X"
    actual = board2.check_result
    board2.show_board
    assert_equal(expect, actual, __method__)
  end

  def test_horizontal_winner2
    # test with O
    board92 = Board.new
    (0..2).each do |element|
      board92.update_board(2, element, "\e[1;31mO\e[0m")
    end
    expect = "O"
    actual = board92.check_result
    board92.show_board
    assert_equal(expect, actual, __method__)
  end

  def test_vertical_winner
    board3 = Board.new
    (0..2).each do |row|
      board3.update_board(row, 2, "\e[1;31mO\e[0m")
    end
    expect = "O"
    actual = board3.check_result
    board3.show_board
    assert_equal(expect, actual, __method__)
  end

  def test_diagonal1
    board4 = Board.new
    (0..2).each do |element|
      board4.update_board(element, element, "\e[1;36mX\e[0m")
    end
    expect = "X"
    actual = board4.check_result
    board4.show_board
    assert_equal(expect, actual, __method__)
  end

  def test_diagonal2
    board5 = Board.new
    (0..2).each do |element|
      board5.update_board(element, 2 - element, "\e[1;36mX\e[0m")
    end
    expect = "X"
    actual = board5.check_result
    board5.show_board
    assert_equal(expect, actual, __method__)
  end

  def test_reset
    board6 = Board.new
    board6.update_board(1, 1, "\e[1;36mX\e[0m")
    board6.show_board
    expect = Board.new
    expect.show_board
    expect = expect.board_status
    actual = board6.reset
    assert_equal(expect, actual, __method__)
  end

  def test_no_winner
    actual = Board.new.check_result
    expect = "none"
    assert_equal(expect, actual, __method__)
  end


end

test = BoardTest.new
test.run
