class GameSettings
  attr_reader :max, :guess_limit

  def initialize(max: 10, guess_limit: nil)
    @max = max
    @guess_limit = guess_limit
  end
end
