
class Entity
  attr_reader :name, :description, :drops

  def initialize sym, data
    @name = sym.to_s.split('_').join(' ')
    @determiner = data[:determiner] || 'a'
    @damage = data[:damage] || []
    @description = data[:description]
    @health = data[:health]
    @drops = Assets::get_item data[:drops]
    @weakness = Assets::get_item data[:weakness]
  end

  def determined_name
    "#{@determiner} #{@name}"
  end

  def tick player
    damage = @damage.sample
    return if damage <= 0
    player.take_damage damage, "#{determined_name.capitalize} attacks you."
  end

  def take_damage item
    if item.nil?
      damage = 1
    else
      damage = item.weapon_damage
      damage *= 5 if @weakness == item
    end
    @health = [0, @health - damage].max
    return damage
  end

  def dead?
    @health <= 0
  end
end
