class Game
  attr_accessor :move_list, :grid
  

  def initialize
    @move_list = []
    @grid = [[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]]
  end

  def winner?
    row_winner? || col_winner? || diag_winner?
  end

  def register(move)
    @move_list << move
    x = move.loc[:x]
    y = move.loc[:y]
    @grid[x][y] = move.symbol
  end

  def row_winner?
    (@grid[0][0] == @grid[0][1] && @grid[0][1] == @grid[0][2] && @grid[0][2]) ||
    (@grid[1][0] == @grid[1][1] && @grid[1][1] == @grid[1][2] && @grid[1][2]) ||
    (@grid[2][0] == @grid[2][1] && @grid[2][1] == @grid[2][2] && @grid[2][2])
  end

  def col_winner?
    (@grid[0][0] == @grid[1][0] && @grid[1][0] == @grid[2][0] && @grid[2][0]) ||
    (@grid[0][1] == @grid[1][1] && @grid[1][1] == @grid[2][1] && @grid[2][1]) ||
    (@grid[0][2] == @grid[1][2] && @grid[1][2] == @grid[2][2] && @grid[2][2])
  end

  def diag_winner?
    (@grid[0][0] == @grid[1][1] && @grid[1][1] == @grid[2][2] && @grid[2][2]) ||
    (@grid[2][0] == @grid[1][1] && @grid[1][1] == @grid[0][2] && @grid[0][2])
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
