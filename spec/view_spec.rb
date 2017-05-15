require 'rspec'
require 'view'
require 'pry'

describe 'TTTView' do
  let(:view) {TTTView.new}

  it '.print_board' do
    expected = 
"-\#-\#-
\#\#\#\#\#
-\#-\#-
\#\#\#\#\#
-\#-\#-"
    actual = view.print_board
    #binding.pry
    expect(actual.eql? expected).to be true
  end
end