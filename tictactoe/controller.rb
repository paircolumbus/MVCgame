require_relative 'globals'



class GameController
  include GameView
  include GameState
  include GameModel

  def run!
    # Print::display("Mikes page!" , ["Some stuff is crazy", "and that is why I love it", "be peaceful my friend"], "~Kenworthy", 80)
    @currState = InitState.new
    Print::initialize("Hello world!", "~Kenworthy inc", 80)

    until @currState.is_a? EndState do
      
      Print::display(@currState.getBody)

      nextState = @currState.send(Print::getInput(@currState.getQuestion))

      (nextState = Complete.new if (checkFTW(Model::board) || Model::board.full?)) if @currState.is_a? Turn 

      @currState = nextState
    end

  end

  def checkFTW(board)
    puts "Heres the board!"
    p board.data

    winBoard = Array.new(3) { Array.new(board.size) { nil } }
    (board.size-1).times do |i|
      winBoard[0][i] = board.data[i][0]
      winBoard[1][i] = board.data[0][i]
    end
    winBoard[2][0] = board.data[0][0]
    winBoard[2][1] = board.data[0][board.size-1]

    # puts "Heres the unchecked winners board!"
    # p winBoard


    board.size.times do |r|
      board.size.times do |c|
        # puts "Row #{r} Col #{c}"
        # puts "Winboard value #{winBoard[1][c]} Board value #{board.data[r][c]}"
        winBoard[1][c] = false unless(board.data[r][c] && winBoard[1][c] && board.data[r][c].class == winBoard[1][c].class)
        winBoard[0][r] = false unless(board.data[r][c] && winBoard[0][r] && board.data[r][c].class == winBoard[0][r].class)

        if c == r
          winBoard[2][0] = false unless(board.data[r][c] && winBoard[2][0] && board.data[r][c].class == winBoard[2][0].class)
        end
        if (c + r) == (board.size-1)
          winBoard[2][1] = false unless(board.data[r][c] && winBoard[2][1] && board.data[r][c].class == winBoard[2][1].class)
        end
      end
    end

    # puts "here are the winners!"
    puts "There was a winner?"
    p winBoard.flatten.any?
    p winBoard
    rcd = -1
    num = -1
    if winBoard.flatten.any?
      winBoard.size.times do |c|
        winBoard[c].size.times do |r|
          if winBoard[r][c]
            Model::winning_position = [r,c] 
            Model::winner = winBoard[r][c].owner
            return true
          end
        end
      end
    end
    false

  end

end



GameController.new.run!
