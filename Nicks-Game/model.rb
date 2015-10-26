class Hangman
  attr_reader :word, :guessed
  MAX_TRIES = 10

  def initialize
    @word = File.readlines('words.txt').sample.strip.upcase
    @letters_left = @word.dup
    @guessed = []
    @tries = 0
  end

  # apply a user's guessed character
  def guess(char)
    @guessed.push(char)
    @tries += 1
    @letters_left.delete! char
  end

  # is the game over?
  def done
    @tries >= MAX_TRIES || guessmatch
  end

  # do the user's combined guesses reveal the secret word?
  def guessmatch
    @letters_left.empty?
  end

  # start a new game
  def reset
    initialize
  end

  # sends hash of gamestate (string, tries) through controller to view
  def play
    playString = ''
    word.chars.each do |letter|
      if guessed.include?(letter)
        playString += letter + ' '
      else
        playString += '_ '
      end
    end
    { playString: playString, tries: MAX_TRIES - @tries }
  end
end
