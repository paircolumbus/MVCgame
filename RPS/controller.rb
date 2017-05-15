require_relative 'view'
require_relative 'model'

class RPSController
  include RPSView

  attr_reader :choices
  
  def initialize
    @choices = {"rock" => 1, "paper" => 2, "scissors" => 3}
  end

  def run!
    # choices = Choices.new
    player = Player.new
    Print::title

    loop do
      Print::menu
      case get_input.to_i
      when 1
        num_rounds = 0
        loop do
          num_rounds = get_input(Print::request_rounds).to_i
          if num_rounds > 0 and num_rounds < 6
            break
          else
            Print::error_message
          end
        end
        num_rounds.times { |x| play(x + 1, player) }
        print_player_results(player)
        update_score(player)
        player.reset
      when 2
        puts "Records"
        print_player_records(player)
      when 3
        puts "Thanks for playing. Goodbye!"
        exit
      else
        Print::error_message
      end
    end

  end

  def play(number, player)
    comp_value = rand(1..3)
    comp_choice = choices.key(comp_value)
    loop do
      print "Round #{number}! "
      case get_input(Print::request_rps)
      when "rock"
        Print::run_spinner
        puts "PLAYER: rock\t\tCOMPUTER: #{comp_choice}"
        determine_outcome("rock", comp_value, player) #DRY. need to refactor
        break
      when "paper"
        Print::run_spinner
        puts "PLAYER: paper\t\tCOMPUTER: #{comp_choice}"
        determine_outcome("paper", comp_value, player)
        break
      when "scissors"
        Print::run_spinner
        puts "PLAYER: scissors\tCOMPUTER: #{comp_choice}"
        determine_outcome("scissors", comp_value, player)
        break
      else
        Print::error_message
      end
    end    
  end

  def print_player_records(player)
    puts "Games won: #{player.game_wins}"
    puts "Games lost: #{player.game_losses}"
    puts "Games tied: #{player.game_ties}"
  end

  def update_score(player)
    if player.round_wins > player.round_losses
      player.win_game
    elsif player.round_wins < player.round_losses
      player.lose_game
    else
      player.tie
    end
  end

  def print_player_results(player)
    puts "Wins: #{player.round_wins} Losses: #{player.round_losses}"
  end

  def get_input(question=nil)
    puts question if question
    print "> "
    gets.chomp.downcase
  end

  def play_again?
    ['y', 'yes'].include? get_input
  end

  def determine_outcome(player_choice, computer_value, player)
    player_value = choices[player_choice]
    difference = player_value - computer_value
    if difference == 0
      Print::player_ties
    elsif difference == 1 or difference == -2
      Print::player_wins
      player.win_round
    else
      Print::player_loses
      player.lose_round
    end
  end

end

RPSController.new.run!