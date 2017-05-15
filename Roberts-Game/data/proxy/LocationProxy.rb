
class LocationProxy
  def initialize data
    @raw = data
  end

  def short_description
    target.short_description
  end

  def long_description
    target.long_description
  end

  def paths
    target.paths
  end

  def environmental_effect
    target.environmental_effect
  end

  def items
    target.items
  end

  def blocked? direction
    target.blocked? direction
  end

  def delete_item item
    target.delete_item item
  end

  def contains? item
    target.contains? item
  end

  def entities
    target.entities
  end

  def tick player
    target.tick player
  end

  def delete_entity player
    target.delete_entity player
  end

  private

  def target
    @target = Location.new @raw if @target.nil?
    return @target
  end
end
