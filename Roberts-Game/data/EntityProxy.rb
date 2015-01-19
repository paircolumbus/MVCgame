
class EntityProxy
  def initialize sym, raw
    @sym = sym
    @raw = raw
  end

  def name
    target.name
  end

  def description
    target.description
  end

  def determined_name
    target.determined_name
  end

  def tick player
    target.tick player
  end

  def take_damage item
    target.take_damage item
  end

  def dead?
    target.dead?
  end

  def drops
    target.drops
  end

  private

  def target
    @target = Entity.new @sym, @raw if !@target
    return @target
  end
end
