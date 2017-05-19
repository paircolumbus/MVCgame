module View

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

     ********** | **********
     *      BARTENDER      *
     ********** | **********

TITLE
        puts title
      end

      def menu
        menu = <<EOS

       ***** Welcome *****
       - (V)iew your beers
       - (A)dd a beer
       - (E)dit a beer
       - (D)elete a beer
       - (S)ort list
       - (Q)uit program
       *******************

EOS
        puts menu
      end

      def print_list(beers)
        beers.each { |b| puts "     " + b.to_s }
      end

      def serialize_add_beer
        prompts = [
          "\nEnter the name:",
          "\nEnter the brewer:",
          "\nEnter your rating (/100):"
        ]
        {}.tap do |obj|
          prompts.each do |t| 
            if obj.empty?
              obj[:name] = get_input(t)
            elsif obj.size == 1
              obj[:brewer] = get_input(t)
            else
              obj[:rating] = get_input(t).to_i
            end
          end
        end
      end

      def serialize_edit_beer name, brewer, rating
        prompts = [
          "\nEnter new name or blank to leave as #{name}",
          "\nEnter new brewer or blank to leave as #{brewer}",
          "\nEnter new rating or blank to leave as #{rating}"]
        {}.tap do |obj|
          prompts.each do |t|
            if obj.empty?
              obj[:name] = get_input_or_default(name, t)
            elsif obj.size == 1
              obj[:brewer] = get_input_or_default(brewer, t)
            else
              obj[:rating] = get_input_or_default(rating, t).to_i
            end
          end
        end
      end

      def get_input question=nil
        puts question if question
        print "> "
        gets.chomp
      end

      def get_input_or_default default, question=nil
        puts question if question
        print "> "
        input = gets.chomp
        input == "" ? default : input
      end
    end
  end
end
