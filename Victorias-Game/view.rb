module GameView
  module  Print
    class << self
      def  run_spinner
        print "Loading, Please Wait"
        5.times { print  "."; sleep 1; }
        print  "\n"
      end

      def  error_message
        puts "That's not a command key. Try again."
      end

      def title_screen
title = <<TITLE

        ----------||----------
        |     Crazy Cats     |
        ----------||----------

TITLE
        puts title
      end

      def menu
menu = <<EOS

        ----- Welcome -----
        - (V)iew your Cats
        - (A)dd a Cats
        - (F)eed a Cat
        - (S)ell a Cat
        - (Q)uit program
        -------------------
EOS
        puts menu
      end

      def print_list(cats)
        cats.each do |cat|
          if cat.fed?
            puts "[X] #{cat.id} || #{cat.title} - #{cat.description}"
          else
            puts "[ ] #{cat.id} || #{cat.title} - #{cat.description}"
          end
        end
      end

      def serialize_cat
        {}.tap  do |obj|
          ["\nEnter the title:", "\nEnter the description:"].each do |t|
            if obj.empty?
              obj[:title] = fetch_user_input(t)
            else
              obj[:description] = fetch_user_input(t)
            end
          end
        end
      end

      def sell_id
        gimme_id = "\nEnter the id of cat item you want to SELL:"
        fetch_user_input(gimme_id)
      end

      def feed_id
        gimme_id = "\nEnter the id of cat item you want to mark as FEED:"
        fetch_user_input(gimme_id)
      end

      def fetch_user_input(question=nil)
        puts question if question
        print "> "
        gets.chomp
      end
    end
  end
end
