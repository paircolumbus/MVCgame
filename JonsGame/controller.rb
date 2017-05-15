require_relative 'view'
require_relative 'retirement_account_scenario'

class GameController
  include GameView

  def run!
    sample_values = {name: "Sample Scenario", beginning_age: 23}
    scenario1 = RetirementAccountScenario.new sample_values
    scenario2 = RetirementAccountScenario.new sample_values

    Print::run_spinner
    Print::title_screen

    loop do
      Print::menu
      case Print::fetch_user_input
      when "V"
        Print::print_retirement_comparison(scenario1, scenario2)
      when "S1"
        scenario1 = RetirementAccountScenario.new Print::serialize_scenario
      when "S2"
        scenario2 = RetirementAccountScenario.new Print::serialize_scenario
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
