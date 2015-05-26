module VoteView
  module Print

    class << self
      def title_screen
        title = <<TITLE
     ********** || **********
     *   POLLING STATION    *
     ********** || **********

TITLE
        puts title
      end

      def menu
        menu = <<EOS
     ********* Menu *********
      - (S)how votes
      - (A)dd an item
      - (V)ote for an item
      - (D)elete an item
      - (W)inning item
      - (Q)uit program
     ************************
EOS
        puts menu
      end

      def not_present_error(name)
        puts "#{name} is not present anyways!"
      end

      def item_not_added_error(name)
        puts "#{name} has not been added!"
      end

      def invalid_option_error
        puts "Invalid option!"
      end

      def goodbye
        puts "See you later!"
      end

      def show_votes(items)
        if items.any?
          puts items.map { |item| "#{item.name}:\t#{ '·' * item.votes }" }.join "\n"
        else
          puts "No votes!"
        end
      end

      def winner(winners)
        case winners.size
        when 0
          puts "No votes yet!"
        when 1
          puts "#{winners.first} is in the lead!"
        else
          puts "#{winners.join ", "} are in the lead!"
        end
      end

      def get_item
        fetch_user_input("Enter your item:")
      end

      def get_vote
        fetch_user_input("Enter what you are voting for:")
      end

      def get_deletion
        fetch_user_input("Enter what you want to delete:")
      end

      def fetch_user_input(question=nil)
        puts question if question
        print "> "
        gets.chomp
      end
    end
  end
end
