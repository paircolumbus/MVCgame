class Game
  attr_accessor :moves
  

  def initialize
    @moves = []
  end



  def winner?

  end
end

class Move
  attr_reader :symbol, :loc, :game
  @@count = 0

  def initialize(x_loc, y_loc, game)
    @@count += 1
    @id = @@count
    @loc = {x: x_loc, y: y_loc}
    @game = game

    add_move_to_register
  end

  # move this method to the controller?
  def add_move_to_register
    @game.moves << @loc
  end
end

# g = Game.new
# m1 = Move.new(2,2,g)
# m2 = Move.new(1,1,g)

# p g.moves

