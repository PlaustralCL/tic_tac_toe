# frozen_string_literal: true

require_relative "./test"
require_relative "../lib/game/game"

# Testing for the game class
class GameTest < Test
  def test_input_names
    game = Game.new
    puts "Enter 'Joe' and 'Bob' when prompted"
    expect = %w[Joe Bob]
    game.input_names
    actual = [game.players[0].name, game.players[1].name]
    assert_equal(expect, actual, __method__)
  end
end

test = GameTest.new
test.run
