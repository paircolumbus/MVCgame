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
        {text: 'X'.red,
         shale: nil}
      end
    end

    @xpos = 0
    @ypos = 0

    @word = "hidesay"
    @is_empty = ->(x,y){@board[x][y][:shale].nil?}

    @surface = -> (){map_square{|s| s[:text]}}
    @wordloc = intersperse_word(@word)
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
      @board[x][y][:shale] = c.upcase.yellow
    end
  end


  def move(dir)

    @board[@ypos][@xpos][:text] = 'X'.red
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

    View::moved(@surface.(), @ypos, @xpos, dir)
  end





end


