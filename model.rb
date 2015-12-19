class Game
  attr_accessor :move_list, :grid
  
  def initialize
    @move_list = []
    @grid = [[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]]
  end

  def register(move)
    x = move.loc[:x]
    y = move.loc[:y]
    @grid[x][y] = move.symbol

    @move_list << move
  end

  def winner?
    result = false
    # check rows, columns for winner
    for i in 0..2
      result ||= (@grid[i][0] == @grid[i][1] && @grid[i][1] == @grid[i][2] && @grid[i][2])
      result ||= (@grid[0][i] == @grid[1][i] && @grid[1][i] == @grid[2][i] && @grid[2][i])
    end
    # check diagonals for winner
    result ||= (@grid[0][0] == @grid[1][1] && @grid[1][1] == @grid[2][2] && @grid[2][2])
    result ||= (@grid[0][2] == @grid[1][1] && @grid[1][1] == @grid[2][0] && @grid[2][0])
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
    @symbol = @id.even? ? "O" : "X"
  end
end
