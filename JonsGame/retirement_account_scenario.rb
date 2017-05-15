require 'faker'
require 'pry'

class RetirementAccountScenario
  attr_reader :name, :beginning_age, :retirement_age, :death_age
  attr_reader :ira_type, :annual_contribution
  attr_reader :accumulation_market_return_rate, :accumulation_tax_rate
  attr_reader :retirement_tax_rate

  VALID_IRA_TYPES = [ :roth, :regular]

  def initialize args 
    @name                            = args.fetch(:name, "UNNAMED")
    @beginning_age                   = args.fetch(:beginning_age, 25).to_f
    @retirement_age                  = args.fetch(:retirement_age, 65).to_f
    @death_age                       = args.fetch(:death_age, 100).to_f
    @annual_contribution             = args.fetch(:annual_contribution, 500).to_f
    @accumulation_market_return_rate = args.fetch(:accumulation_market_return_rate, 0.01).to_f
    @accumulation_tax_rate           = args.fetch(:accumulation_tax_rate, 0).to_f
    @retirement_tax_rate             = args.fetch(:retirement_tax_rate, 0).to_f
    @ira_type                        = args.fetch(:ira_type, :regular)

    raise ArguementError "Retirement must be after beginning age" unless retirement_age > beginning_age
    raise ArguementError "Death must be after retirement" unless death_age > retirement_age
    raise ArguementError "Must earn interest" unless accumulation_market_return_rate > 0
    raise ArguementError "Must contribute" unless annual_contribution > 0
    raise ArguementError unless VALID_IRA_TYPES.include?(ira_type)
  end

  def retirement_income
    yearly_withdraw = (balance_at_retirement / years_in_retirement).round
    if ira_type == :roth
      yearly_withdraw
    else #Must take out taxes
      (yearly_withdraw * (1.0 - retirement_tax_rate)).round
    end
  end

  private

  def balance_at_retirement
    # http://www.moneychimp.com/articles/finworks/fmbasinv.htm
    z = 1 + accumulation_market_return_rate
    if ira_type == :roth
      c = annual_contribution * (1.0 - accumulation_tax_rate)
    else
      c = annual_contribution
    end
    y = years_in_accumulation

    c * ( ( z**(y + 1) - z ) / ( z - 1 ))
  end

  def years_in_retirement
    death_age - retirement_age
  end

  def years_in_accumulation
    retirement_age - beginning_age
  end

end

