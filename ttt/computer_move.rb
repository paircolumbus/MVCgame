# original method:
def get_best_move(board, next_player, depth = 0, best_score = {})
  best_move = nil
  available_spaces(board).each do |as|
    space = as.to_i
    board[space] = @com
    if game_is_over(board)
      best_move = space
      board[space] = as
      return best_move
    else
      board[space] = @hum
      if game_is_over(board)
        best_move = space
        board[space] = as
        return best_move
      else
        board[space] = as
      end
    end
  end
  if best_move
    return best_move
  else
    n = rand(0..available_spaces.count)
    return available_spaces[n].to_i
  end
end

def available_spaces(board)
  available_spaces = []
  board.each do |space|
    if space != "X" && space != "O"
      available_spaces << space
    end
  end
end

def move(spot)
  @spot = spot
  @board[@spot.to_i] = @current_turn
end

def eval_board
  if @board[4] == @center
    @board[4] = @current_turn
  else
    spot = get_random_move(@board)
    @board[spot] = @current_turn
  end
end

def get_random_move(board)
  available_spaces = []
  random_move = nil
  board.each do |s|
    if s != @X && s != @O
      available_spaces << s
    end
  end
  return available_spaces.sample.to_i
end

def game_is_over
  winner(@board) || tie(@board) ? true : false
end

def winner(board)
  [board[0], board[1], board[2]].uniq.length == 1 ||
  [board[3], board[4], board[5]].uniq.length == 1 ||
  [board[6], board[7], board[8]].uniq.length == 1 ||
  [board[0], board[3], board[6]].uniq.length == 1 ||
  [board[1], board[4], board[7]].uniq.length == 1 ||
  [board[2], board[5], board[8]].uniq.length == 1 ||
  [board[0], board[4], board[8]].uniq.length == 1 ||
  [board[2], board[4], board[6]].uniq.length == 1
end

def tie(board)
  board.all? { |spot| spot == @X || spot == @O }
end
