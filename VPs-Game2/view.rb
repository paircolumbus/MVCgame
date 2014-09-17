
module View
INITIAL = <<BLOCK
A*************************
B*************************
C*************************
D*************************
E*************************
F*************************
G*************************
H*************************
I*************************
J*************************
BLOCK

  class << self

    def initial
      msg = "MOVE WITH WASD"
      puts INITIAL.sub(/F.*/, msg)
    end


    def moved(board, xpos, ypos, dir)
      board[xpos][ypos] = 'O'.green
      print_board(board)
      puts "moved #{dir}"
    end

    def print_board(board)
      x = board.size
      y = board.first.size
      x.times do |x|
        puts board[board.size - x - 1].join("")
      end
    end






  end
end

