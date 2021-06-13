# frozen_string_literal: true

require_relative "../color"

# Class for performing basic tests
class Test
  def run
    tests = methods.select { |method| method.to_s.start_with?("test_") }
    tests.each { |test| send(test) }
  end

  def assert_equal(expected, actual, test_name)
    if expected == actual
      puts "#{'Passed'.green} #{test_name}. #{actual} is #{expected} as expected"
    else
      puts "#{'Failed'.red} #{test_name}. Expected #{expected} but got #{actual}"
    end
  end
end
