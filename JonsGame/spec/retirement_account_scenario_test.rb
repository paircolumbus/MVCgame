require_relative '../retirement_account_scenario'

describe RetirementAccountScenario do
  describe "#retirement_income" do
    context "when given valid parameters" do
      subject(:valid_scenario) {
        setup_values = {}
        setup_values[:name]                            = "Valid Account"
        setup_values[:beginning_age]                   = 35
        setup_values[:retirement_age]                  = 65
        setup_values[:death_age]                       = 95
        setup_values[:annual_contribution]             = 5000
        setup_values[:accumulation_market_return_rate] = 0.08
        setup_values[:ira_type]                        = :roth
        RetirementAccountScenario.new setup_values
      }

      it "correctly calculates income" do
        expect(valid_scenario.retirement_income).to eq(20391) 
      end
    end

    context "when roth is given accumulation tax rate" do
      subject() {
        setup_values = {}
        setup_values[:name]                            = "Valid with Tax Rate"
        setup_values[:beginning_age]                   = 35
        setup_values[:retirement_age]                  = 65
        setup_values[:death_age]                       = 95
        setup_values[:annual_contribution]             = 5000
        setup_values[:accumulation_market_return_rate] = 0.08
        setup_values[:accumulation_tax_rate]           = 0.28
        setup_values[:ira_type]                        = :roth
        RetirementAccountScenario.new setup_values
      }
      it "reduces contributions by tax rate" do 
        expect(subject.retirement_income).to eq(14682) 
      end
    end

    context "when roth is given retirement tax rate" do
      subject() {
        setup_values = {}
        setup_values[:name]                            = "Valid with Tax Rate"
        setup_values[:beginning_age]                   = 35
        setup_values[:retirement_age]                  = 65
        setup_values[:death_age]                       = 95
        setup_values[:annual_contribution]             = 5000
        setup_values[:accumulation_market_return_rate] = 0.08
        setup_values[:accumulation_tax_rate]           = 0.28
        setup_values[:retirement_tax_rate]             = 0.20
        setup_values[:ira_type]                        = :roth
        RetirementAccountScenario.new setup_values
      }
      it "does not reduce retirement income" do 
        expect(subject.retirement_income).to eq(14682) 
      end
    end

    context "when a regular retirement account" do
      subject() {
        setup_values = {}
        setup_values[:name]                            = "Regular retirement account"
        setup_values[:beginning_age]                   = 35
        setup_values[:retirement_age]                  = 65
        setup_values[:death_age]                       = 95
        setup_values[:annual_contribution]             = 5000
        setup_values[:accumulation_market_return_rate] = 0.08
        setup_values[:accumulation_tax_rate]           = 0.28
        setup_values[:retirement_tax_rate]             = 0.20
        setup_values[:ira_type]                        = :regular
        RetirementAccountScenario.new setup_values
      }
      it "gets taxed in retirement" do
        expect(subject.retirement_income).to eq (16313)
      end
    
    end
  end

  describe "#initialize" do
    context "when a required parameter is missing" do
      it { expect { RetirementAccountScenario.new nothing: "yes" }.to_not raise_error() }
    end
  end
end
