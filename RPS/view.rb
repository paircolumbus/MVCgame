module RPSView

  module Print

    class << self
      def title
title = <<TITLE

     +=+=+=+=+=+=+=+=+=+=+=+
     | ROCK PAPER SCISSORS |
     +=+=+=+=+=+=+=+=+=+=+=+

TITLE
      
        puts title
      end

      def menu
menu = <<MENU

         *---Welcome---*
         | (1) Play    |
         | (2) Records |
         | (3) Quit    |
         *-------------*

MENU
        puts menu
      end

      def request_rounds
        puts "Enter how many rounds you'd like to play (1-5)?"
      end

      def request_rps
        puts "Choose rock, paper, or scissors."
      end

      def run_spinner
        print "Rock..."; sleep 0.5;
        print "Paper..."; sleep 0.5;
        print "Scissors..."; sleep 0.5;
        puts "SHOOT!";
      end

      def player_wins
        puts "You WIN!"
      end

      def player_ties
        puts "You TIED!"
      end

      def player_loses
        puts "You LOSE"
      end

      def play_again?
        puts "Play again? Y"
      end

      def error_message
        puts "Invalid input. Please try again!"
      end

    end
  end
end