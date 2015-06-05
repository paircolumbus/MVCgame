require 'rspec'
require 'model'
require 'pry'

describe 'TTT' do

  let(:game) { TTT.new}

  it '.initialize' do 
    expected = Array.new(10, "-")
    expect(game.board.eql? expected).to be true
  end

  it '.place_mark' do
    expected = Array.new(10, "-")
    expected[1] = "O"
    game.place_mark 1
    #binding.pry
    expect(game.board.eql? expected ).to be true
  end

  it '.start_game' do
    game.start_game
    expect(game.player1turn == true). to be true
    expected = Array.new(10, "-")
    expect(game.board.eql? expected).to be true
  end

  it '.check_horizontals123' do
    game.place_mark 1
    game.place_mark 4
    game.place_mark 2
    game.place_mark 5
    game.place_mark 3
    expect(game.check_horizontals).to be true
  end

  it '.check_horizontals12' do
    game.place_mark 1
    game.place_mark 4
    game.place_mark 2
    game.place_mark 5
    expect(game.check_horizontals).to be false
  end

  it '.check_horizontals789' do
    game.place_mark 7
    game.place_mark 4
    game.place_mark 8
    game.place_mark 5
    game.place_mark 9
    #binding.pry
    expect(game.check_horizontals).to be true
  end

  it '.check_verticals147' do
    game.place_mark 1
    game.place_mark 5
    game.place_mark 4
    game.place_mark 6
    game.place_mark 7
    #binding.pry
    expect(game.check_verticals).to be true
  end

  it '.check_verticals369' do
    game.place_mark 3
    game.place_mark 5
    game.place_mark 6
    game.place_mark 4
    game.place_mark 9
    expect(game.check_verticals).to be true
  end

  it '.check_diagonals159' do
    game.place_mark 1
    game.place_mark 2
    game.place_mark 5
    game.place_mark 3
    game.place_mark 9
    expect(game.check_diagonals).to be true
  end

  it '.check_diagonals357' do
    game.place_mark 3
    game.place_mark 2
    game.place_mark 5
    game.place_mark 1
    game.place_mark 7
    expect(game.check_diagonals).to be true
  end

  it '.check_diagonalsfail' do
    game.place_mark 1
    game.place_mark 2
    game.place_mark 3
    game.place_mark 4
    game.place_mark 5
    expect(game.check_diagonals).to be false
  end
end