module GameView

 module Print

   class << self
     def error_message
        puts "That's not a command key. Try again!"
     end

     def title_screen
title = <<TITLE

     ************************
     *        WHO SAY       *
     ************************

TITLE
       puts title
     end

      def menu
menu = <<EOS

       ***** Welcome *****
       - (N)ew game
       - (R)ules
       - (Q)uit program
       *******************

EOS
        puts menu
      end

      def rules
rules = <<EOS

       ***** Rules ************************
       * Guess the word that is being said
       ************************************

EOS
        puts rules
      end

WHAT = <<EOS

       **********************
       *
       *
       *
       *
       *    X
       *
       *
       *
       *
       * WHAT DID I JUST SAY?
       *
       *
       *
       *
       *
       *
       *
       *
       *
       *
       *
       **********************

EOS
      def what
        puts WHAT.sub("X", "")
      end

      def what_try_again
        puts WHAT.sub("X", "OK, TRY AGAIN")
      end

      def another(word)
another = <<EOS

       **********************
       *
       *
       *
       *
       *
       *
       *
       *
       * IT WAS BABABABA
       * OK, HERE IS ANOTHER
       *
       *
       *
       *
       *
       *
       *
       *
       *
       *
       *
       **********************

EOS
        puts another.sub("BABABABA", word)
      end

      def fetch_user_input(question=nil)
        puts question if question
        print "> "
        gets.chomp.upcase
      end

    end

  end

end
