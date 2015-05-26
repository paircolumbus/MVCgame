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
        new_item = Print::get_item
        vote_counter.add_item!(new_item)
      when "V"
        item = Print::get_vote
        items = vote_counter.items
        if (index = items.map { |x| x.name }.find_index(item)) != nil
          items[index].vote!
        else
          Print::error_message "#{item} has not been added!"
        end
      when "D"
        to_delete = Print::get_deletion
        if vote_counter.delete!(to_delete)
          Print::error_message "#{to_delete} deleted"
        else
          Print::not_present_error to_delete
        end
      when "W"
        Print::winner(vote_counter.winning_items.map { |x| x.name })
      when "Q"
        Print::goodbye
        exit
      else
        Print::error_message "Invalid option!"
      end
    end
  end
end

VoteController.new.run!
