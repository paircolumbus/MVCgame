require_relative 'view'
require_relative 'model'

class GameController
  include GameView

  def run!
  	Print::intro
  	pet_type = Print::get_pet_type
    pet_name = Print::get_pet_name(pet_type)
    my_pet = Pet.new({
    	:petName => pet_name, 
    	:petType => pet_type
    	})
    loop do
      Print::menu(my_pet)
      case Print::fetch_user_input
      when "1"
        my_pet.feed
      when "2"
        my_pet.provide_water
      when "3"
        my_pet.play
      when "4"
        my_pet.clean_waste
      when "5"
      	my_pet.tuck_in
      when "q"
        puts "We're done" 
        exit
      else
        Print::error_message
      end
      if my_pet.nutrition >= 20 && my_pet.hydration >= 20 && my_pet.socialization >= 20 && my_pet.cleanliness >= 20 && my_pet.energy >= 20
      	Print::win
      	exit
      elsif my_pet.nutrition <= 0 || my_pet.hydration <= 0 || my_pet.socialization <= 0 || my_pet.cleanliness <= 0 || my_pet.energy <= 0
      	Print::lose
      	exit
      end
    end

  end
end
GameController.new.run!