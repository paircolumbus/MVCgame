require_relative 'view'

class Model
  attr_accessor :board, :xpos, :ypos, :xmax, :ymax

  def initialize
    @xmax = 8
    @ymax = 8

    @board = @xmax.times.map do |i|
      @ymax.times.map do |j|
        'X'.red
      end
    end

    @xpos = 0
    @ypos = 0
  end

  def move(dir)
    @board[@xpos][@ypos] = 'X'.red
    case dir
    when :up
      @ypos = ( @ypos + 1 == @ymax ? @ypos : @ypos + 1 )
    when :down
      @ypos = ( @ypos - 1 < 0 ? @ypos : @ypos - 1 )
    when :left
      @xpos = ( @xpos - 1 < 0 ? @xpos : @xpos - 1 )
    when :right
      @xpos = ( @xpos + 1 == @xmax ? @xpos : @xpos + 1 )
    end
    
    View::moved(@board, @ypos, @xpos, dir)
  end





end


