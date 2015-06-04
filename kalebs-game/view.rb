module GameView

  module Print

    class << self
      def run_loader
        print "Loading, please wait"
        5.times { print "*"; sleep 1; }
        print "\n"
      end

      def error_message
        puts "I don't understand that command"
      end

      def title_screen
        title = <<TITLE
              Welcome to Yahtzee!
TITLE
        puts title
      end

      def menu
        menu = <<EOS
              Press R to roll the dice!
              Press Q to quit.
EOS
        puts menu
      end

      def print_die(value)
        puts " ---"; puts "| #{value} |"; puts " ---"
        puts "\n"
      end

      def fetch_user_input(question=nil)
        puts question if question
        print "> "
        gets.chomp
      end

      def did_i_win(value)
        case value
        when true
          puts "Congrats, you got Yahtzee! Keep playing if you want."
        else
          puts "Keep playing..."
        end
      end

    end

  end

end
