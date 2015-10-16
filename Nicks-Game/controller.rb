require_relative 'view'
require_relative 'model'

class GameController
  include GameView

  def run!
    hangman = Hangman.new

    Print::run_spinner
    Print::title_screen

    #Make todoList methods like RESTful endpoints (new/edit/update/delete)
    #Think Backbone Model & View

    loop do
      Print::menu
      case Print::fetch_user_input
      when "P"
        hangman.reset
        Print::play hangman
        loop do
          hangman.guess(Print::fetch_user_input)
          if hangman.done
            Print::finish
            break
          else
            Print::play hangman
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
