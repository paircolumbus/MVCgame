module JuegoView
  module Print
    class << self
      def title_screen
        title = <<TITLE
              ==========================
              *X*X*X* ANTCRUSHER *X*X*X*
              ==========================

TITLE
        puts title
      end

      def error_message
        puts "What? That doesn't make sense. Try again."
      end

      def menu_screen
        menu = <<MENU 
              *X*X*X* ANTCRUSHER *X*X*X*
                       (1) PLAY
                       (2) HELP
                       (3) QUIT

MENU
        puts menu
      end

      def help_screen
        help = <<HELP
    Your goal is to fire the cannon and hit the ant.
    The ant is located less than 100 feet away from 
    you. After every time you fire, the ant will 
    move one foot in either direction or choose not 
    to move at all. You will get feedback on how far 
    away your cannon landed, but we don't know if you 
    you shot too far or too short. The game ends once 
    you crush the ant. Fire away comrade!

HELP
        puts help
      end

      def fire_screen
fired = <<WAIT

                             /      
      ___________________ . /        ___
      |  /\|/\           | .        /   \  
      |_|--*--|__________| . ,      \___/
         \/|\/            . \
                             \

WAIT
puts fired
        sleep 3
      end

      def checking_screen
        wait = <<WAIT
                    *PLEASE WAIT*
              Intercepting intel brief... 

WAIT
        puts wait
        sleep 3
      end

      def ant_alive_screen
        ant_alive = <<TROLLANT
 \\                    /
  \\__________________/
   /    __    __     \\         _____   __________
  [    [__]  [__]      ]       /    \\ /          \
  \\  ,_____________,  |______|_______|___________|
   \\ \\_\_\_\_\_\__|  |      /\\     /\\        /\\
    \\   '\_\_\_\_\_/  |     /  \\   /  \\      /  \\
     \\_______________/

              THE ANT DONE TROLLED YOU!

TROLLANT
        puts ant_alive
      end

      def ant_dead_screen
        ant_dead = <<DEADANT
                      
  /\ ________________ /\
 / /      _    _      \ \       _____   __________
  |      [X]  [X]      |       /     \ /          \
  |      ________      |______|_______|___________|
   \    /        \    /       /\      /\         /\
    \  /__________\  /       /  \    /  \       /  \
     \______________/

          MISSION ACCOMPLISHED. ANT CRUSHED!

DEADANT
        puts ant_dead
      end

      def fetch_user_input(question = nil)
        puts question if question
        print ("> ")
        gets.chomp
      end

      def menu_response
        response = "What would you like to do?"
        fetch_user_input(response)
      end

      def shot_distance
        distance = "How far do you want to shoot this cannonball? (0-100 feet)"
        fetch_user_input(distance)
      end

      def miss_screen(distance)
        puts "Your shot was #{distance} feet off. \n\n"
      end
    end
  end
end