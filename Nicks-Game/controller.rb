require_relative 'view'
require_relative 'model'

class GameController
  include GameView

  def run!
    hangman = Hangman.new

    Print::run_spinner
    Print::title_screen

    loop do
      Print::menu
      case Print::fetch_user_input
      when "P"
        hangman.reset
        Print::play(hangman.play)
        loop do
          hangman.guess(Print::fetch_user_input)
          if hangman.done
            Print::finish(hangman.word)
            break
          else
            Print::play(hangman.play)
          end
        end
      when "Q"
        puts "We're done" 
        exit
      else
        Print::error_message
      end
    end
  end
end

GameController.new.run!
