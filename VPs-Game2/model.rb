require_relative 'view'

module Model
  BOARD = 8.times.map do |i|
    8.times.map do |j|
      'X'.red
    end
  end

  XPOS = 0
  YPOS = 0

  class << self





    def move(dir)
      case dir
      when :up
        YPOS += 1
      when :down
        YPOS -= 1
      when :left
        XPOS -= 1
      when :right
        XPOS += 1
      end
      View::moved(BOARD, XPOS, YPOS)
    end





  end
end


