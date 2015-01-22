require_relative "Command"
require_relative "data/assets"

module GameView

  module Print

    class << self

      def idk_message
        puts Assets::get_string :idk
      end

      def title_screen
        puts Assets::get_string :title
      end

      def state_description player
        puts player.location.long_description
      end

      def fetch_command
        print "\n> "
        command = Command::parse gets.chomp
        puts
        return command
      end

      def exit_message
        puts Assets::get_string :bye
      end

      def help_message
        puts Assets::get_string :help
      end

      def look_around_message player
        show_player_health player
        show_player_messages player
        show_player_location player
        show_player_inventory player
      end

      def death_message player
        show_player_health player
        show_player_messages player
        exit_message
      end
      
      def win_message
				puts Assets::get_string :win_message
			end

      private

      def show_player_messages player
        return if player.messages.empty?
        player.messages.each { |message| puts message }
        player.clear_messages
      end

      def show_player_health player
        health_meter = "HP [" + "=" * player.health + " " * (10 - player.health) + "]"

        human_message = Assets::get_string case player.health
    																			 when 10 then Assets::get_string :hp_perfect
																					 when 8...10 then Assets::get_string :hp_okay
																					 when 4...8 then Assets::get_string :hp_not_so_good
																					 when 1...4 then Assets::get_string :hp_dying
																					 else Assets::get_string :hp_dead
																					 end

        puts "#{health_meter} #{human_message}"
        puts "YOU ARE GODLY." if player.godly?
			end

      def show_player_location player
        puts player.location.long_description
        puts player.location.environmental_effect.ambient_description if !player.location.environmental_effect.nil?

        player.location.items.each do |place,item|
          case place
          when :ground
            place_string = " on the ground"
          when :north, :south, :east, :west
            place_string = " to the #{place.to_s}"
          else
            place_string = ""
          end
          puts "There is #{item.determined_name}#{place_string}."
        end

        player.location.paths.each do |direction,location|
          puts "To the #{direction.to_s}, you can see #{location.short_description}." if !player.location.blocked? direction
        end

        player.location.entities.each { |entity| puts "#{entity.determined_name.capitalize} is here." }
      end

      def show_player_inventory player
        puts "You are holding: #{player.inventory.map {|item| "#{item.determiner} #{item.name}"}.join(", ")}" if !player.inventory.empty?
        puts "You have #{player.weapon.determined_name} equipped." if !!player.weapon
        puts "You have #{player.armor.determined_name} equipped." if !!player.armor
      end
    end
  end
end
