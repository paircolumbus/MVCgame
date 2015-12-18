require_relative "model"
require_relative "view"

class Controller
  def execute
    # show menu
    @game = Game.new
    @board = Board.new
    new_move
    # new moves until game is over
    # display game information
    # show menu
  end

  def show_menu
    # display some stuff
    # get input to start game
    # should this be in the view?
  end

  def new_move
    # request, parse, and validate input
    move = Move.new(input, @game)
    @board.add_to_pixel_array(move)
    @board.draw
    # model.add_to_register(move)
    # view.add_to_pixel_array(move)
    # view.draw
  end

  def input
    print "row (1-3): "
    x = gets.chomp.to_i
    print "column (1-3): "
    y = gets.chomp.to_i
    {x: x, y: y}
  end


end

c = Controller.new
c.execute

