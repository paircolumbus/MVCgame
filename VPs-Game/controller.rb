require_relative 'view'
require_relative 'model'

class GameController
  include GameView

  def run!
    Print::title_screen

    sayit = SayIt.new
    word = sayit.random_word


    loop do
      Print::menu
      cmd = Print::fetch_user_input
      case cmd
      when "N"
        @word = sayit.random_word
        loop do
          sayit.say(@word)
          sayit.first_try ? Print::what : Print::what_try_again

          cmd = Print::fetch_user_input
          case cmd.upcase
          when @word.upcase
            msg = "Correct! You win."
            puts msg
            sayit.says(msg)
            break
          when /Q|QUIT|EXIT/
            Print::another(@word)
            sayit.say("it was " + @word)
            sayit.say(@word)
            sayit.says(@word)
            @word = sayit.random_word
          else
            sayit.first_try = false
          end
        end

      when "R"
        Print::rules
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
