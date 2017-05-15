module GameView

	module Print

		class << self

			#main menu
			def title_screen
			  title = <<TITLE
			  ********** ||| **********
			  *  ROCK PAPER SCISSORS  *
			  ********** ||| **********
TITLE
			  puts title
			end

			#invalid input
			def error_message
				puts "That's not rock, paper, or scissors. Try again!"
			end

			#winner
			def winning_message
#			  crown = <<CROWN
#				,  ,() , ,
#				|\/\/\/\/|
#				|_o_<>_o_|
#CROWN
#		    puts crown
			  puts "YOU WIN"
			end

			#loser
			def losing_message
#			  skull = <<SKULL
#	      		      _____
#                 /     \
#                | () () |
#                 \  ^  /
#                  |||||
#SKULL
#              puts skull
        puts "YOU LOSE"
      end

      def tie_message
        puts "YOU TIE"
      end

      def new_match
        puts "Your Turn -- R for ROCK, P for PAPER, S for SCISSORS"
        print "> "
        gets.chomp
      end

      def matchup(player_move,computer_move)
        puts "#{player_move} vs #{computer_move}" 
      end
      
      def score(player_score,computer_score)
        puts "YOU: #{player_score}"
        puts "COMPUTER: #{computer_score}"
      end
    end
  end
end




