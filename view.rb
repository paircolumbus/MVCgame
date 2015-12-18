class Menu
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

  # private
  def total_length(square_length)
    3 * square_length - 1
  end

  # move this to the model?
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

  def add_move_to_pixel_array(symbol, location)
    x_dim = pixelize(location[:x], @square_width)
    y_dim = pixelize(location[:y], @square_height)
    @pixel_array[y_dim][x_dim] = symbol
  end

  def pixelize(value, square_length)
    (value - 0.5) * square_length - 1
  end

end

# b = Board.new
# b.add_move_to_pixel_array("X", {x: 1, y: 1})
# b.draw
