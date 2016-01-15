require_relative 'view'
require_relative 'model'

class StartController
  include JuegoView

    def run!
      Print::title_screen
      
      loop do
        Print::menu_screen

        case Print::menu_response
        when "1"
          JuegoController.new.play!
        when "2"
          Print::help_screen
        when "3"
          puts "~ Adios amigo ~"
          exit
        else
          Print::error_message
      end
    end
  end
end

class JuegoController
  include JuegoView

    def play!
      ant = Ant.new
      cannon_ball = CannonBall.new

      Print::title_screen

      loop do
        if ant.alive?
          cannon_ball.fire(Print::shot_distance)
          Print::fire_screen
          Print::checking_screen
        end
        if ant.hit?(cannon_ball.distance)
          Print::ant_dead_screen
          break
        else
          Print::ant_alive_screen
          Print::miss_screen(ant.missed(cannon_ball.distance))
          ant.move
        end
      end


    end
  end

StartController.new.run!