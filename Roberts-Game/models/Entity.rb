
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

  def take_damage damage
  	if damage.kind_of? ItemProxy
  		damage_amount = damage.weapon_damage
  		damage_amount *= 5 if @weakness == damage
		elsif
			damage_amount = damage
  	end
    @health = [0, @health - damage_amount].max
    return damage_amount
  end

  def dead?
    @health <= 0
  end
end
