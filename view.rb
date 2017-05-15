class Menu
  def list_options
    puts ""
    puts "(S)tart game"
    puts "(R)eview last game"
    puts "(Q)uit"
    puts ""
    print "Your choice: "
  end
end

class Board

  def initialize
    # for good presentation, square width and height should both be even
    @square_width = 6
    @square_height = 4
    @pixel_array = []
    set_pixel_array
  end

  def draw
    @pixel_array.each{ |row| puts row.join }
  end

  def add_to_pixel_array(move)
    x_dim = pixelize(move.loc[:x], @square_height)
    y_dim = pixelize(move.loc[:y], @square_width)
    @pixel_array[x_dim][y_dim] = move.symbol
  end

  private
  def total_length(square_length)
    3 * square_length - 1
  end

  def set_pixel_array
    for row in 1..total_length(@square_height)
      row_output = []
      for col in 1..total_length(@square_width)
        if row % @square_height == 0 && col % @square_width == 0
          row_output << "+"
        elsif row % @square_height == 0
          row_output << "-"
        elsif col % @square_width == 0
          row_output << "|"
        else
          row_output << " "
        end
      end
      @pixel_array << row_output
    end
  end

  def pixelize(value, square_length)
    (value + 0.5) * square_length - 1
  end

end
