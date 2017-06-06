module GameView

  module Print

	class <<self

	  def error_message
		puts "Invalid command, try again!"
	  end

	  def title_screen
title = <<TITLE

    ************ || **************
    * Ultimate Grandma Simulator *
    ************ || **************
                   
                  "Just like the real thing!"

TITLE
        puts title
      end

      def menu
menu = <<EOS

    ********* Menu *********
    - Say hi to Grandma! (1)
    - How to play        (2)
    - Exit               (3)
    *********      *********

EOS
        puts menu
      end

      def show_instructions
instructions = <<INS

	Talk to Grandma any time you want! Be sure to give her a good name.

	Grandma is a little hard of hearing, so be sure to speak up!

	Make sure Grandma gets the food she needs, tell her "EAT, GRANDMA!"
	but watch out, food puts her to sleep! Yell three times to wake her up.   

INS
		puts instructions
	  end

	  def get_input(prompt=nil)
    	puts prompt if prompt
    	print "> "
    	gets.chomp
      end
    end
  end
end
