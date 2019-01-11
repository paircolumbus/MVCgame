def get_best_move(board, next_player, depth = 0, best_score = {})
  available_spaces = get_available_spaces(board)
  best_move = nil
  available_spaces.each do |as|
    board[as.to_i] = @com
=begin
          if game_is_over(board)
            best_move = as.to_i
            board[as.to_i] = as
            return best_move
=end
=begin
          else
            board[as.to_i] = @hum
            if game_is_over(board)
              best_move = as.to_i
              board[as.to_i] = as
              return best_move
=end
=begin
            else
              board[as.to_i] = as
            end
          end
=end
  end
=begin
        if best_move
          return best_move
=end
=begin
        else
          n = rand(0..available_spaces.count)
          return available_spaces[n].to_i
        end
=end
end
