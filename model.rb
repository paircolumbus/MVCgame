class Game
  attr_accessor :moves
  

  def initialize
    @moves = []
  end



  def winner?

  end

  def add_to_register(move)
    @game.moves << move
  end
end

class Move
  attr_reader :symbol, :loc, :game
  @@count = 0

  def initialize(location, game)
    @@count += 1
    @id = @@count
    @loc = location
    @game = game
    @symbol = @id.even? ? "X" : "O"
  end

end

# g = Game.new
# m1 = Move.new(2,2,g)
# m2 = Move.new(1,1,g)

# p g.moves

