# frozen_string_literal: true

# Adds color to strings printed to the terminal
class String
  def colorize(special=0, color_code)
    "\e[#{special};#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end

  def bold_red
    colorize(1, 31)
  end

  def bold_green
    colorize(1, 32)
  end

  def bold_yellow
    colorize(1, 33)
  end

  def bold_blue
    colorize(1, 34)
  end

  def bold_pink
    colorize(1, 35)
  end

  def bold_light_blue
    colorize(1, 36)
  end
end

if $PROGRAM_NAME == __FILE__
  puts "Testing red".red
  puts "Testing bold red".bold_red
  puts "testing green".green
  puts "testing bold green".bold_green
  puts "testing blue".blue
  puts "testing bold blue".bold_blue
end
