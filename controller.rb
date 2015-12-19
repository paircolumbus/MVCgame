require_relative "model"
require_relative "view"

class Controller
  def execute
    # show menu
    @game = Game.new
    @board = Board.new
    # 5.times {new_move}
    while !@game.winner? do
      new_move
    end
    puts "It's over!  #{@game.winner?}'s win"
    # display game information
    # show menu
  end

  def show_menu
    # display some stuff
    # get input to start game
    # should this be in the view?
  end

  def new_move
    input = get_input
    while !valid?(input) do 
      input = get_input
    end
    move = Move.new(input, @game)
    @game.register(move)
    @board.add_to_pixel_array(move)
    @board.draw
  end

  # move this to model too?
  def get_input
    print "row (1-3): "
    x = gets.chomp.to_i - 1
    print "column (1-3): "
    y = gets.chomp.to_i - 1
    {x: x, y: y}
  end

  # move this to the model?
  def valid?(input)
    x = input[:x]
    y = input[:y]
    if x < 0 || x > 2 || y < 0 || y > 2
      puts "That move is out of bounds"
      false
    elsif !@game.grid[x][y].nil?
      puts "That square is already full"
      false
    else
      true
    end
  end


end

c = Controller.new
c.execute

