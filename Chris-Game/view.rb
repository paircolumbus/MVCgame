module DeafGrandmaView
	
	module Print
		
		class << self
			def title
				content = <<TITLE

Welcome to Grandma Simulator 2017!
**********************************

TITLE
				puts content
			end
			def main_menu
				content = <<MENU
Please select an option:
N - New Game
T - Tutorial
E - Exit
MENU

				puts content
			end

			def game input
				grandma = <<GMA
  .---.
 (_---_)
(_/6 6\\_)   #{input} 
 (  v  )
  `\\o/'
GMA

				puts grandma
			end

			def bye
				goodbye = <<GOODBYE

**** SEE YA SONNY! ****

GOODBYE
				puts goodbye
			end

			def error
				error = <<ERROR

**** COME AGAIN SONNY?! ****

ERROR
				puts error
			end
			
			def tutorial
				tutorial = <<TUTORIAL

                 **** TUTORIAL ****
Welcome to grandma simulator 2017! Select 'N' to start a new
converstion with grandma, and she'll respond to what you say.

P.S. Grandma is a little hard of hearing in her old age, so 
you have to speak up if you want to talk to her.

TUTORIAL
				
				puts tutorial
			end

			def get_user_input
				gets.chomp
			end
		end
	end
end
