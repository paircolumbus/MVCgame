class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = "X" # the computer's marker
    @hum = "O" # the user's marker
  end

  def play_game
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n===+===+===\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n===+===+===\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
    puts "Enter [0-8]:"
    until winner || tie
      get_human_move
      if !winner && !tie
        get_computer_move
      end
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n===+===+===\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n===+===+===\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
    end
    puts winner ? "game over: winner" : "game over: tie"
  end

  def get_human_move
    space = nil
    until space
      space = gets.chomp.to_i
      space_available?(space) ? @board[space] = @hum : space = nil
    end
  end

  def get_computer_move
    space_available?(4) ? @board[4] = @com : @board[get_best_space] = @com
  end

  def space_available?(space)
    @board[space] != "X" && @board[space] != "O"
  end

  def get_best_space
    available_spaces = []
    get_available_spaces(available_spaces)
    best_move = nil
    available_spaces.each do |space|
      @board[space.to_i] = @com
      # winning_move
      if winner
        best_move = space.to_i
        @board[space.to_i] = space
        return best_move
      else
        @board[space.to_i] = @hum
        # block_winning_move
        if winner
          best_move = space.to_i
          @board[space.to_i] = space
          return best_move
        else
          # reset board
          @board[space.to_i] = space
        end
      end
    end
    get_random_move(available_spaces)
  end

  #receives board array, returns array of available spaces
  def get_available_spaces(available_spaces)
    @board.each do |space|
      if space != "X" && space != "O"
        # if space_available?(space.to_i).....ignoring for now, but need to integrate
        available_spaces << space
      end
    end
    return available_spaces
  end

  def get_random_move(available_spaces)
    return available_spaces.sample.to_i
  end

  def winner
    [@board[0], @board[1], @board[2]].uniq.length == 1 ||
    [@board[3], @board[4], @board[5]].uniq.length == 1 ||
    [@board[6], @board[7], @board[8]].uniq.length == 1 ||
    [@board[0], @board[3], @board[6]].uniq.length == 1 ||
    [@board[1], @board[4], @board[7]].uniq.length == 1 ||
    [@board[2], @board[5], @board[8]].uniq.length == 1 ||
    [@board[0], @board[4], @board[8]].uniq.length == 1 ||
    [@board[2], @board[4], @board[6]].uniq.length == 1
  end

  def tie
    @board.all? { |space| space == "X" || space == "O" }
  end
end

game = Game.new
game.play_game
