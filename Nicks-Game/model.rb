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

  # start a new game
  def reset
    initialize
  end

  # sends hash of gamestate (string, tries) through controller to view
  def play
    playString = ''
    @word.chars.each do |letter|
      if guessed.include?(letter)
        playString += letter + ' '
      else
        playString += '_ '
      end
    end
    { playString: playString, tries: @maxtries - @tries }
  end
end
