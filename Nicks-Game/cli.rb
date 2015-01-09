require 'optparse'
require_relative 'game'
require_relative 'game_settings'

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: ruby cli.rb [options]'

  opts.on('-m', '--max MAX', 'set the maximum number to guess from') do |v|
    options[:max] = v.to_i
  end

  opts.on('-g', '--guess_limit GUESS_LIMIT', 'set the number of guesses allowed') do |v|
    options[:guess_limit] = v.to_i
  end
end.parse!

game = Game.new options

puts 'Welcome to the guessing game!'
puts "You have #{game.settings.guess_limit || 'unlimited'} tries to guess a number from 1 to #{game.settings.max}."
loop do
  if game.guesses_remaining == 0
    puts 'You ran out of tries... You lose!'
    exit
  else
    if game.guesses_remaining
      print "Guess #{game.guesses_used + 1} of #{game.settings.guess_limit}: "
    else
      print "Guess #{game.guesses_used + 1}: "
    end

    result = game.guess gets.to_i
    case result
    when 0
      puts 'You won!'
      exit
    when -1 then puts 'Higher...'
    when 1 then puts 'Lower...'
    end
  end
end
