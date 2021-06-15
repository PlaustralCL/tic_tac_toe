# frozen_string_literal: true

require_relative "./color"

# Tracks the name and marker of the user
class User
  attr_accessor :marker
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
