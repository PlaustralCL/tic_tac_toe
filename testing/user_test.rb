# frozen_string_literal: true

require_relative "./test"
require_relative "../user"

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

  def test_choose_first_marker_x
    player = User.new("Joe")
    player.choose_first_marker
    actual = player.marker
    expected = "\e[1;36mX\e[0m"
    assert_equal(expected, actual, __method__)
  end

  def test_choose_first_marker_o
    player = User.new("Joe")
    player.choose_first_marker
    actual = player.marker
    expected = "\e[1;31mO\e[0m"
    assert_equal(expected, actual, __method__)
  end
end

test = UserTest.new
test.run
