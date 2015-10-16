module GameView

 module Print

   class << self
     def run_spinner
       print "Loading (please wait) "
       5.times { print "."; sleep 0.5; }
       print "\n"
     end

     def error_message
        puts "That's not a command key. Try again!"
     end
       
     def title_screen
title = <<TITLE

     ********** || **********
     *        Hangman       *
     ********** || **********

TITLE
       puts title
     end

      def menu
menu = <<EOS

       ***** Welcome *****
       - (P)lay
       - (Q)uit
       *****         *****

EOS
        puts menu
      end

      def play(hangman)
        puts "Guess a letter (#{hangman.maxtries - hangman.tries} tries remaining) (ctrl-c to quit):"
        hangman.word.chars.each do |letter|
          if hangman.guessed.include?(letter)
            print letter + ' '
          else
            print '_ '
          end
        end
      end

      def finish
        puts "Thanks for playing!"
        Print::run_spinner
      end

      def fetch_user_input(question=nil)
        puts question if question
        print "> "
        gets.chomp
      end
    end
  end
end
