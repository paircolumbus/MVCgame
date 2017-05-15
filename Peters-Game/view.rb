module AttendanceView

 module Print

   class << self
     def run_spinner
       print "Loading (please wait) "
       5.times { print "."; sleep 0.5; }
       print "\n"
     end

     def error_message
        puts "That's not a command key. Try again!"
     end

     def title_screen
title = <<TITLE

     ********** || **********
     *   ATTENDANCE MAGIC   *
     ********** || **********

TITLE
       puts title
     end

      def menu
menu = <<EOS

       ***** Welcome *****
       - (VT) - View Today's attendance list
       - (VA) - View all Attendance
       - (AA) - Add Attendance entry
       - (MAA) - Mark Attendance Absent
       - (MAP) - Mark Attendance Present
       - (DA) - Delete Attendance entry

       - (VP) - View all People
       - (AP) - Add Person
       - (DP) - Delete Person (and Attendance)

       - (Q) - Quit program
       *****         *****

EOS
        puts menu
      end

      def print_list(collection)
        collection.each {|item| puts item }
      end

      def get_attendance_input
        serialize_attendance.tap do |obj|
          obj[:date] = Date.today.to_s if obj[:date].empty?
        end
      end

      def serialize_attendance
        serialize_item ({
          date:   "\nEnter the date(e.g. '2015-05-27'), leave blank for today:",
          person: "\nEnter the person's ID:"
        })
      end

      def serialize_person
        serialize_item ({
          name: "\nEnter the person's NAME:"
        })
      end

      def serialize_item(question_hash)
        question_hash.tap do |obj|
          obj.each do |key,prompt|
            obj[key] = fetch_user_input(prompt)
          end
        end
      end

      def deleted_id(id_type)
        gimme_id = "\nEnter the #{id_type} id you want to DELETE:"
        fetch_user_input(gimme_id)
      end

      def marked_present_id
        gimme_id = "\nEnter the attendance id you want to mark as PRESENT:"
        fetch_user_input(gimme_id)
      end

      def marked_absent_id
        gimme_id = "\nEnter the attendance id you want to mark as ABSENT:"
        fetch_user_input(gimme_id)
      end

      def fetch_user_input(question=nil)
        puts question if question
        print "> "
        gets.chomp
      end
    end
  end
end
