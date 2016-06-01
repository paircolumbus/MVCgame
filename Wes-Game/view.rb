module GameView

 module Print

   class << self

     def error_message
        puts "That's not a command key. Try again!"
     end

      def menu
menu = <<EOS

       ***** Welcome *****
       - (V)iew your wines
       - (A)dd a wine
       - (D)elete a wine
       - (Q)uit program
       *****         *****

EOS
        puts menu
      end

      #does print_list know too much about the underlying object???

      def print_list(wines)
        wines.each do |wine|
          puts "====================="
          puts wine.name
          puts "====================="
          puts "Type: #{wine.type}"
          puts "Comments: #{wine.comments}"
          puts "Rating: #{wine.rating}"
        end
      end

      def serialize_wine
        new_wine = {}
        print "\nEnter the name: "
        new_wine[:name] = gets.chomp
        print "\nEnter the type: "
        new_wine[:type] = gets.chomp
        print "\nEnter comments: "
        new_wine[:comments] = gets.chomp
        print "\nEnter a rating (0-10): "
        new_wine[:rating] = gets.chomp
        return new_wine
      end

      def deleted_name
        print "\nEnter the name of wine you want to DELETE: "
        gets.chomp
      end

      def fetch_user_input(question=nil)
        puts question if question
        print "> "
        gets.chomp
      end
    end
  end
end
