
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


    def moved(dir)
      puts "moved #{dir}"
    end







  end
end

