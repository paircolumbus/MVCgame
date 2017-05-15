require_relative 'Screen'
require_relative 'WordFactory'

class Game
  def initialize
    @guesses = []
    @misses = []
    @words = WordFactory.get_words
    @screen = Screen.new
  end

  def run
    loop do
      state = @screen.get_state @misses.count
      lines = show_lines

      @screen.write "Game State: "
      @screen.write state

      @screen.write "Word or Phrase: "
      @screen.write lines

      unless lines.include? '_'
        @screen.write "You Win!"

        quit_game
      end

      if @misses.count == 6
        @screen.write "Game Over!"
        @screen.write "The word or phrase was: #{@words.map{ |word| word.get_word }.join(' ')}"

        quit_game
      end

      input = @screen.ask_for_input("What is your guess?").downcase

      response = check_guess input

      @screen.write response if response
    end
  end

  def show_lines
    @words.map{ |word|
      word.get_lines @guesses
    }.join ' '
  end

  def check_guess guess
    quit_game if guess == "quit"

    return "Invalid input!" unless input_is_valid? guess

    if @guesses.include? guess
      return "You already guessed that letter!"
    end

    @guesses.push guess

    @misses.push guess if !@words.map{ |word| word.get_word }.join.include? guess

    return nil
  end

  def input_is_valid? input
    return !!(input =~ /[a-z]/i) && (input.length == 1)
  end

  def quit_game
    exit
  end
end
