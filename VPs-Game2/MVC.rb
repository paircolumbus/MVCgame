require 'pry'
require 'colorize'

INITIAL = <<BLOCK
**************************
**************************
**************************
**************************
**************************
**************************
**************************
**************************
**************************
**************************
BLOCK

module Controller
  include Model

  puts INITIAL

  loop do

    input = gets.chomp.upcase
    case input
    when "W"
      Model::move(:up)
    when "S"
      Model::move(:down)
    when "A"
      Model::move(:left)
    when "D"
      Model::move(:right)
    end

  end

end






module Model
  include View


  def move(dir)
    View::moved(dir)

  end

end


module View
  def moved(dir)
    puts "moved #{dir}"
  end
end

