class Player
  attr_reader :round_wins, :round_losses, :game_wins, :game_losses, :game_ties

  def initialize
    @round_wins = 0
    @round_losses = 0
    @game_wins = 0
    @game_losses = 0
    @game_ties = 0
  end

  def win_round
    @round_wins += 1
  end

  def lose_round
    @round_losses += 1
  end

  def win_game
    @game_wins += 1
  end

  def lose_game
    @game_losses += 1
  end

  def tie
    @game_ties += 1
  end

  def reset
    @round_wins = 0
    @round_losses = 0
  end

  def update(player)
    @game_wins = player.game_wins
    @game_losses = player.game_losses
  end

end

# class Choices
#   attr_reader :hash

#   def initialize
#     @hash = {"rock" => 1, "paper" => 2, "scissors" => 3}
#   end

# end