class Hangman
  attr_reader :word, :guessed, :tries, :maxtries

  def initialize
    @word = "special".upcase
    @guessed = []
    @tries = 0
    @maxtries = 10
  end

  # apply a user's guessed character
  def guess char
    @guessed.push(char.upcase)
    @tries += 1
  end

  # is the game over?
  def done
    if @tries >= @maxtries
      true
    elsif guessmatch
      true
    else
      false
    end
  end

  # do the user's combined guesses reveal the secret word?
  def guessmatch
    @word.chars.all? { |letter| @guessed.include?(letter) }
  end

  def reset
    initialize
  end
end
