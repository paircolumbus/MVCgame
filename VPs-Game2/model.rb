require_relative 'view'

class Model
  attr_accessor :board,
                :xpos,
                :ypos,
                :xmax,
                :ymax,
                :word,
                :is_empty


  def initialize
    @xmax = 8
    @ymax = 8

    @board = @xmax.times.map do |i|
      @ymax.times.map do |j|
        {
          text: 'X'.red,
          shale: nil,
          cursor: nil,
        }
      end
    end

    @xpos = 0
    @ypos = 0
    @board[@xpos][@ypos][:cursor] = :right

    @word = "hidesay"
    @is_empty = ->(x,y){@board[x][y][:shale].nil?}

    @surface = -> (){
      map_square{|s|
        if s[:cursor]
          if s[:shale]
            s[:shale].yellow
          else
            s[:cursor]
          end
        else
          s[:text]
        end
      }
    }

    intersperse_word(@word)
  end


  def each_square()
    @xmax.times do |x|
      @ymax.times do |y|
        yield(@board[x][y])
      end
    end
  end

  def map_square
    @xmax.times.map do |x|
      @ymax.times.map do |y|
        yield(@board[x][y])
      end
    end
  end


  def board
    @surface.()
  end


  def get_a_random_square
    [rand(@xmax), rand(@ymax)]
  end

  def get_a_random_empty_square
    x,y = get_a_random_square
    if @is_empty.(x,y)
      [x,y]
    else
      get_a_random_empty_square
    end
  end


  def intersperse_word(word)
    word.each_char do |c|
      x,y = get_a_random_empty_square
      @board[x][y][:shale] = c.upcase
    end
  end


  def move(dir)

    @board[@ypos][@xpos][:cursor] = nil
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
    @board[@ypos][@xpos][:cursor] = :right
    if !@board[@ypos][@xpos][:shale].nil?
      Thread.new do
        View::sayit(@board[@ypos][@xpos][:shale])
      end
    end

    View::moved(@surface.(), @ypos, @xpos, dir)
  end





end


