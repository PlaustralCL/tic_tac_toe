# frozen_string_literal: true

require_relative "./test"
require_relative "../lib/game/user"

# Testing for user.rb
class UserTest < Test
  def test_new_user
    player1 = User.new("Bob")
    expected = "Bob"
    actual = player1.name
    assert_equal(expected, actual, __method__)
  end

  def test_store_marker
    player1 = User.new("Joe")
    player1.marker = "\e[1;36mX\e[0m"
    expected = "\e[1;36mX\e[0m"
    actual = player1.marker
    assert_equal(expected, actual, __method__)
  end

  def test_assgin_first_marker_x
    player = User.new("Joe")
    player.assign_first_marker("x")
    actual = player.marker
    expected = "\e[1;36mX\e[0m"
    assert_equal(expected, actual, __method__)
  end

  def test_assgin_first_marker_o
    player = User.new("Joe")
    player.assign_first_marker("o")
    actual = player.marker
    expected = "\e[1;31mO\e[0m"
    assert_equal(expected, actual, __method__)
  end

  def test_assign_second_marker
    player1 = User.new("Joe")
    player1.marker = "\e[1;36mX\e[0m"
    player1.short_marker = "x"
    player2 = User.new("Bob")
    player2.assign_second_marker(player1.marker, player1.short_marker)
    actual = player2.marker
    expected = "\e[1;31mO\e[0m"
    assert_equal(expected, actual, __method__)
  end
end

test = UserTest.new
test.run
