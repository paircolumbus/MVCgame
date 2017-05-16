require_relative 'view'
require_relative 'model'

class GameController
  include GameView

  def run!
    todo_list = List.new

    Print::welcome

    loop do
      Print::menu
      case Print::fetch_input
      when "V"
        Print::print_list(todo_list.todos)
      when "A"
        Print::add_todo(Print::serialize_todo)
      when "C"
        Print::complete_todo(Print::completed_id.to_i)
      when "D"
        Print::delete_todo(Print::deleted_id.to_i)
      when "Q"
        puts "Thanks for playing!"
        exit
      else
        Print::error_message
      end
    end
  end
end

GameController.new.run!
