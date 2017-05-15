require_relative 'view'
require_relative 'task'
require 'pry'

module ToDo
  class Controller

    def initialize
      @todos = Array.new
    end

    def run
      while true
        View.show_tasklist(@todos)
        View.show_options
        input = gets.chomp

        case input
          when '1'
            View.show_complete_message
            View.show_tasklist(@todos)
            handle_tasks(:complete)
          when '2'
            View.show_add_message
            add_task
          when '3'
            View.show_delete_message
            View.show_tasklist(@todos)
            handle_tasks(:delete)
          when '4'
            View.show_update_message
            View.show_tasklist(@todos)
            handle_tasks(:update)
          when /q(uit)?/i, /e(xit)?/i
            exit
          else
            puts "Your input of '#{input}' was not a valid option."
            puts
        end
      end
    end

    private

    def handle_tasks(type)
      selected_option = get_numbered_input
      return if selected_option == :invalid

      case type
        when :complete
          completed = @todos.delete_at(selected_option)
          View.completed_message(completed.description)
        when :delete
          @todos.delete_at(selected_option)
        when :update
          View.show_update_question
          update_task(@todos[selected_option])
      end
    end

    def get_numbered_input
      option = gets.chomp
      unless option =~ /\d+/
        puts "Choose a number. '#{option}' is not a valid number"
        return :invalid
      end

      actual_option = option.to_i - 1
      if actual_option >= @todos.length
        puts "'#{option}' is not a valid choice."
        return :invalid
      end
      actual_option
    end

    def add_task
      description = gets.chomp
      @todos << Task.new(description)
    end

    def update_task(task)
      new_description = gets.chomp
      task.description = new_description
    end
  end
end

ToDo::Controller.new.run

=begin
1) add commands

Nice to haves:
2) add ability to add tasks to certain days
3) add color to menu
4) dependency injection
=end