require_relative 'game_settings'

class Game
  attr_reader :settings, :guesses_used, :guesses_remaining
  def initialize(options = {})
    @settings = GameSettings.new(options)
    @winning_number = rand(1..@settings.max)
    @guesses_used = 0
    @guesses_remaining = @settings.guess_limit
  end

  def guess(number)
    unless @guesses_remaining.nil?
      raise RunTimeError, 'No guesses remaining' unless @guesses_remaining > 0
      @guesses_remaining -= 1
      @guesses_used += 1
    end

    number <=> @winning_number
  end
end
