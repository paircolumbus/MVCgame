require 'pry'
require 'colorize'
require_relative 'model'
require_relative 'view'

module Controller
  include Model
  class << self





    def run!
      View::initial

      loop do

        system("stty raw -echo")
        #input = gets.chomp.upcase
        input = STDIN.getc
        system("stty -raw echo")
        case input.upcase
        when "W"
          Model::move(:up)
        when "S"
          Model::move(:down)
        when "A"
          Model::move(:left)
        when "D"
          Model::move(:right)
        when "6"
          exit
        end
      end
    end




  end
end



Controller::run!
