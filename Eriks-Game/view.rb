module WallView

 module Print

   class << self
     def run_spinner
       print "Ubering to the bar (please wait) "
       5.times { print "."; sleep 1; }
       print "\n"
     end

     def error_message
        puts "That's not a command key. Try again!"
     end

     def title_screen
title = <<TITLE

     ********** || **********
     *      99 Bottles      *
     ********** || **********

TITLE
       puts title
     end

      def menu
menu = <<EOS

       ***** Welcome *****
       - (C)ount the bottles
       - (A)dd a bottle
       - (D)rink a bottle
       - (Q)uit this awful game
       *****         *****

EOS
        puts menu
      end

      #does print_list know too much about the underlying object???

      def count_bottles(bottles)
        puts "There are #{bottles.count} bottles on the wall."
      end

      def serialize_bottle
        {}.tap do |obj|
          ["\nEnter the title:", "\nEnter the description:"].each do |t|
            if obj.empty?
              obj[:title] = fetch_user_input(t)
            else
              obj[:description] = fetch_user_input(t)
            end
          end
        end
      end

      def drink_id(bottles)
        chosen_bottle = bottles.sample

        puts "\nDrinking bottle #{chosen_bottle.id}"
        puts "\nThis is a delicious bottle of #{chosen_bottle.title}"
        puts "\nCritics describe this beer as \"#{chosen_bottle.description}\""
        chosen_bottle.id
      end

      def fetch_user_input(question=nil)
        puts question if question
        print "> "
        gets.chomp.downcase
      end

      def drunk_message
        puts "Don't get too intoxicated!"
      end

      def empty_message
        puts "Sorry, time to head home. The wall is empty"
      end
    end
  end
end
