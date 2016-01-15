module GameView

 module Print

   class << self


     def error_message
        puts "That's not a command key. Try again!"
     end
       
     def title_screen
title = <<TITLE

     ********** || **********
     *   Escape The Woods   *
     ********** || **********

TITLE
       puts title
     end

      def menu
menu = <<EOS

       ***** Welcome *****
       - (1) Select Option 1
       - (2) Select Option 2
       - (3) Select Option 3
       - (Q)uit the Adventure
       *****          *****
EOS
        puts menu
      end

      def win
win = <<win

     ********** || **********
      You Escaped The Woods!
     ********** || **********

win
       puts win
     end

      def print_list(actions)
        actions.each do |action|
          puts "#{action.id}) #{action.title}"
        end
      end

      def select_option(option, actions)
        option = actions.select { |action| action.id == option }
        puts "\nYou decided to #{option[0].title}"
      end

      def fetch_user_input(question=nil)
        puts question if question
        print "> "
        gets.chomp
      end
    end
  end
end
