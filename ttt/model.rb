class Game
  attr_reader :board, :X, :O
  attr_accessor :mode, :HvC, :HvH, :CvC,
                :order, :first, :second,
                :symbol,
                :difficulty, :easy, :hard, :impossible,
                :current_turn, :space

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @space

    @mode
    @HvC = "Human vs Computer"
    @HvH = "Human vs Human"
    @CvC = "Computer vs Computer"

    @order
    @first = "First"
    @second = "Second"

    @symbol
    @X = "X"
    @O = "O"

    @difficulty
    @easy = "Easy"
    @hard = "Hard"
    @impossible = "Impossible"
    @current_turn = @O
  end

  def set_mode(setting)
    @mode = setting
  end

  def set_order(setting)
    @order = setting
  end

  def set_symbol(setting)
    @symbol = setting
  end

  def set_difficulty(setting)
    @difficulty = setting
  end

  def set_first_turn
    if @symbol == @X
      @current_turn = @order == @first ? @X : @O
    else
      @current_turn = @order == @first ? @O : @X
    end
  end

  def switch_turns
    @current_turn = @current_turn == @X ? @O : @X
  end

  def move(space)
    @space = space
    @board[@space] = @current_turn
  end

  def valid_move(space)
    int = space.to_i
    int.to_s == space &&
    int >= 0 &&
    int <= 8 &&
    @board[int] != @X &&
    @board[int] != @O ?
      true : false
  end

  def get_computer_move
    space_available?(4) ? move(4) : move(get_best_space)
  end

  def space_available?(space)
    @board[space] != @X && @board[space] != @O
  end

  def get_best_space
    available_spaces = get_available_spaces
    if @difficulty == @hard #|| @difficulty == @impossible
      best_move = nil
      available_spaces.each do |space|
        best_move = space.to_i
        @board[best_move] = @current_turn
        if winning_move?(space)
          @board[space.to_i] = space
          return best_move
        else
          @board[best_move] = space
        end
      end
      available_spaces.each do |space|
        best_move = space.to_i
        @board[best_move] = @current_turn
        if block_win?(space)
          @board[space.to_i] = space
          return best_move
        else
          @board[best_move] = space
        end
      end
      # if @difficulty == "Impossible"
      # available_spaces.each do |space|
      #   best_move = space.to_i
      #   @board[best_move] = @current_turn
      #   if block_fork?(space)
      #     @board[space.to_i] = space
      #     return best_move
      #   else
      #     @board[best_move] = space
      #   end
      # end
    end
    get_random_space(available_spaces)
  end

  def winning_move?(space)
    move(space.to_i)
    winner
  end

  def block_win?(space)
    switch_turns
    move(space.to_i)
    switch_turns
    winner
  end

  def block_fork?(space)
  end

  def get_available_spaces
    available_spaces = []
    @board.each do |space|
      # available_spaces << space if space_available?(space.to_i)
      if space != @X && space != @O
        available_spaces << space
      end
    end
    return available_spaces
  end

  def get_random_space(available_spaces)
    return available_spaces.sample.to_i
  end

  def game_is_over
    winner || tie ? true : false
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
    @board.all? { |space| space == @X || space == @O }
  end
end
