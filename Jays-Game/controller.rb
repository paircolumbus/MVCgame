require_relative 'view'
require_relative 'model'

class GameController
  include GameView

  def run!
    todoList = List.new

    Print::run_spinner
    Print::title_screen

    #Make todoList methods like RESTful endpoints (new/edit/update/delete)
    #Think Backbone Model & View

    loop do
      Print::menu
      case Print::fetch_user_input
      when "V"
        Print::print_list(todoList.todos)
      when "A"
        todoList.add_todo(Print::serialize_todo)
      when "C"
        todoList.complete_todo(Print::completed_id.to_i)
      when "D"
        todoList.delete_todo(Print::deleted_id.to_i)
      when "Q"
        puts "We're done" 
        exit
      else
        Print::error_message
      end
    end
  end
end

GameController.new.run!
