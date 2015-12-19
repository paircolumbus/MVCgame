class Game
  attr_accessor :move_list, :grid
  

  def initialize
    @move_list = []
    @grid = [[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]]
  end

  def register(move)
    @move_list << move
    x = move.loc[:x]
    y = move.loc[:y]
    @grid[x][y] = move.symbol
  end

  def winner?
    results = false

    for i in 0..2
      # check row
      results ||= (@grid[i][0] == @grid[i][1] && @grid[i][1] == @grid[i][2] && @grid[i][2])
      # check column
      results ||= (@grid[0][i] == @grid[1][i] && @grid[1][i] == @grid[2][i] && @grid[2][i])
    end

    # check diagonals
    results ||= (@grid[0][0] == @grid[1][1] && @grid[1][1] == @grid[2][2] && @grid[2][2])
    results ||= (@grid[0][2] == @grid[1][1] && @grid[1][1] == @grid[2][0] && @grid[2][0])
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
