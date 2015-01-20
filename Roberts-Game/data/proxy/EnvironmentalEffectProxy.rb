
class EnvironmentalEffectProxy
  def initialize data
    @raw = data
  end

  def ambient_description
    target.ambient_description
  end

  def run player_state
    target.run player_state
  end

  private

  def target
    @target = EnvironmentalEffect.new @raw if @target.nil?
    return @target
  end
end
