require 'pry'

class CannonBall
  attr_reader :distance

  def initialize
    @distance = 0
  end

  def fire(distance)
    @distance = distance
  end

end

class Ant
  attr_reader :location, :status

  def initialize
    @location = rand(90) + 5
    @status = "alive"
  end

  def alive?
    @status == "alive"
  end

  def hit?(distance)
    @location == distance.to_i
  end

  def missed(distance)
    (@location - distance.to_i).abs
  end

  def move
    @location + direction
  end

  def direction
    if @location < 2
      1 - rand(2)
    elsif @location > 98
      0 - rand(2)
    else
      1 - rand(3)
    end
  end

end