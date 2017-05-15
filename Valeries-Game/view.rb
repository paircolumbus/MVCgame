module GameView
  module Print
    class << self
      def intro
        puts "Welcome to the Virtual Pet Foster Simulator!"
        #puts "Type \"Quit\" at any time to quit the game"
        puts "Raise all attributes to 20, and a family will adopt your pet!"
        puts "If a single attribute falls to 0, animal control will assign a more suitable foster..."
      end
      def get_pet_type
        loop do 
          puts "Would you like to foster a cat or a dog?"
          puts "Please type cat or dog."
          petType = gets.chomp.downcase
          return petType if petType == "cat" || petType == "dog"
        end
      end
      def get_pet_name(petType)
        puts "What is your #{petType}'s name?"
        petName = gets.chomp
        puts "#{petName} is almost ready to go!"
        puts "All their attributes are at 15, so they need some more work."
        return petName
      end
      def menu(pet)
        if pet.petType == "cat"
          puts "  /\\___/\\"
          puts " ( ^   ^ )"
          puts " (  =!=   )"
          puts " (         )"
          puts " (          )"
          puts " ( oo   oo   )))))))))))"
        else
          puts "    ___  "
          puts "  //^ ^\\\\"
          puts " (/(_•_)\\)"
          puts " _/''*''\\_"
          puts " (,,,)^(,,,) "
        end
        puts "Here is #{pet.petName}'s current state:"
        puts "Nutrition is at: #{pet.nutrition}"
        puts "Hydration is at: #{pet.hydration}"
        puts "Socialization is at: #{pet.socialization}"
        puts "Cleanliness is at: #{pet.cleanliness}"
        puts "Energy is at: #{pet.energy}"
        puts "Press 1 to feed, 2 to provide water, 3 to play,"
        puts "4 to clean up waste, or 5 to tuck in for the night"
      end
      def fetch_user_input(question=nil)
        puts question if question
        print "> "
        gets.chomp
      end
      def error_message
        puts "That's not a command key. Try again!"
      end
      def win
        puts "You took excellent care of your pet!"
        puts "A wonderful family is adopting them, and they'll always remember their time with you!"
        puts "__     __           _____  _      _   _   _  _ "
        puts "\\ \\   / /          | __  \\ (_)   | | (_) | || |"
        puts " \\ \\_/ /__  _   _  | |  | | _  __| | | |_| || |"
        puts "  \\   / _ \\| | | | | |  | || |/ _` | | |__ || |"
        puts "   | | (_) | |_| | | |__| || | (_| | | | | ||_|"
        puts "   |_|\\___ /\\__,_| | _____/|_|\\__,_| |_| \\__(_)"
        puts "Press any key to exit"
        gets.chomp
      end
      def lose
        puts "You haven't been taking care of your pet very well.."
        puts "Animal control was called in time, they're going to a better foster family."
        puts "YOU LOSE!"
        puts "Press any key to exit"
        gets.chomp
      end
  end
end
end
