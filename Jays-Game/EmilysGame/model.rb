#require 'pry'

class Scorekeeper
  attr_accessor :computer_move, :player_move, :player_score, :computer_score, :win

	def initialize
		@player_score = 0
		@computer_score = 0
    @player_move = nil
    @computer_move = nil
    @win = nil
	end

  def evaluate(player_move)
    @computer_move = generate_computer_move
    @player_move = player_move
    @win = nil
    if @player_move!=@computer_move
      if (@player_move == :rock && @computer_move == :scissors) || 
        (@player_move == :paper && @computer_move == :rock) ||
        (@player_move == :scissors && @computer_move == :paper)

        @player_score+=1
        @win = true
      else
        @computer_score+=1
        @win = false
      end
    end
  end

  def generate_computer_move
    prng = Random.new
    res = prng.rand(3)
    if res == 0
      :rock
    elsif res == 1
      :paper
    else
      :scissors
    end
  end
end