# frozen_string_literal: true

require_relative "../lib/utilities/color"

# Class for performing basic tests
# Based on https://testing-for-beginners.rubymonstas.org/testing/classes.html
class Test
  def run
    tests = methods.select { |method| method.to_s.start_with?("test_") }
    tests.each { |test| send(test) }
  end

  def assert_true(actual, test_name)
    assert_equal(true, actual, test_name)
  end

  def assert_false(actual, test_name)
    assert_equal(false, actual, test_name)
  end

  def assert_equal(expected, actual, test_name)
    if expected == actual
      puts "#{'Passed'.green} #{test_name}. Actual is '#{actual}' as expected"
    else
      puts "#{'Failed'.red} #{test_name}. Expected '#{expected}' but got '#{actual}'"
    end
  end
end
