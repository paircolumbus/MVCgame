require_relative 'model'
require_relative 'view'

class VoteController
  include VoteView

  def run!
    Print::title_screen

    vote_counter = VoteCounter.new

    loop do
      Print::menu

      case Print::fetch_user_input
      when "S"
        Print::show_votes(vote_counter.items)
      when "A"
        vote_counter.add_item(Print::get_item)
      when "V"
        item = Print::get_vote
        Print::item_not_added_error(item) unless vote_counter.vote_for(item)
      when "D"
        to_delete = Print::get_deletion
        Print::not_present_error(to_delete) unless vote_counter.delete(to_delete)
      when "W"
        Print::winner(vote_counter.winning_items.map { |x| x.name })
      when "Q"
        Print::goodbye
        exit
      else
        Print::invalid_option_error
      end
    end
  end
end

VoteController.new.run!
