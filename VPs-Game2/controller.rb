require 'pry'
require 'colorize'
require_relative 'model'
require_relative 'view'

module Controller
  class << self





    def run!
      View::initial
      model = Model.new

      loop do

        system("stty raw -echo")
        #input = gets.chomp.upcase
        input = STDIN.getc
        system("stty -raw echo")
        case input.upcase
        when /W|,/
          model.move(:up)
        when /S|O/
          model.move(:down)
        when /A|A/
          model.move(:left)
        when /D|E/
          model.move(:right)
        when "6"
          exit
        end
      end
    end




  end
end



Controller::run!
