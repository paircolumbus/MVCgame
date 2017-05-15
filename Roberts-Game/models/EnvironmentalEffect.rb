
class EnvironmentalEffect
  attr_reader :ambient_description

  def initialize data
    @do_nothing = !data
    return if @do_nothing

    @ambient_description = data[:ambient_description]
    @damage_description = data[:damage_description]
    @damage = data[:damage]
  end

  def run player_state
    return if @do_nothing
    damage = @damage.sample
    return if damage <= 0
    player_state.take_damage damage, @damage_description
  end

end
