require_relative 'view'
require_relative 'model'

class GameController
  include AttendanceView

  def run!
    attendanceList = List.new

    Print::run_spinner
    Print::title_screen

    loop do
      Print::menu
      case Print::fetch_user_input
      when "VT"
        Print::print_list(attendanceList.todays_attendances)
      when "VA"
        Print::print_list(attendanceList.attendances)
      when "AA"
        attendanceList.add_attendance(Print::get_attendance_input)
      when "MAA"
        attendanceList.mark_absent(Print::marked_absent_id.to_i)
      when "MAP"
        attendanceList.mark_present(Print::marked_present_id.to_i)
      when "DA"
        attendanceList.delete_attendance(Print::deleted_id("attendance").to_i)
      when "VP"
        Print::print_list(attendanceList.people)
      when "AP"
        attendanceList.add_person(Print::serialize_person)
      when "DP"
        attendanceList.delete_person(Print::deleted_id("person").to_i)
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
