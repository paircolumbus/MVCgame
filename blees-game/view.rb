module ToDo
  class View
    class << self
      def show_options
        puts 'Choose one of the available options:'
        puts '1) Complete ToDo'
        puts '2) Add ToDo'
        puts '3) Delete ToDo'
        puts '4) Update ToDo'
        # puts '5) Move ToDo'
        puts 'Exit'
      end

      def show_tasklist(tasks)
        puts '-----------------------'

        if tasks.empty?
          puts 'No tasks to complete right now.'
        else
          tasks.inject(1) do |count, task|
            puts "#{count}) #{task.description}"
            count + 1
          end
        end

        puts '-----------------------'
        puts
      end

      def show_complete_message
        puts 'Choose a task to complete:'
      end

      def show_delete_message
        puts 'Choose a task to delete'
      end

      def show_add_message
        puts 'Enter your ToDo item.'
      end

      def show_update_message
        puts 'Choose a task to update'
      end

      def show_update_question
        puts 'Enter the new description'
      end

      def completed_message(description)
        puts "Yay you finished '#{description}'!!"
        puts
      end

    end
  end
end