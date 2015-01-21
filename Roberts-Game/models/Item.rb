
class Item
  attr_reader :determiner, :takeable, :description, :contains, :is_food, :hp_bonus, :is_weapon, :weapon_damage, :text, :easy_to_read, :is_armor, :damage_protection

  def initialize sym, data
    @sym = sym
    @description = data[:description]
    @is_door = !!data[:is_door]
    @is_food = !!data[:is_food]
    @locked = !!data[:locked]
    @unlocks_with = data[:unlocks_with]
    @determiner = data[:determiner] || 'a'
    @takeable = data[:takeable] || false
    @contains = (data[:contains] || []).map{|sym| Assets::get_item(sym) }
    @hp_bonus = data[:hp_bonus]
    @is_weapon = data[:is_weapon]
    @weapon_damage = data[:weapon_damage]
    @easy_to_read = !!data[:easy_to_read]
    @text = data[:text]
		@is_armor = !!data[:is_armor]
		@damage_protection = data[:damage_protection] || 0

    @unlocks_with = Assets::get_item @unlocks_with if !@unlocks_with.nil?
  end

  def name
    @sym.to_s.split('_').join(' ')
  end

  def blocking?
    @is_door && !@unlocked
  end

  def unlock_with key
    if @unlocks_with == key
      @unlocked = true
      return true
    else
      return false
    end
  end

  def determined_name
    "#{@determiner} #{name}"
  end

  def contains? item
    return true if @contains.member? item
    !!@contains.find { |inner_item| inner_item.contains? item }
  end

  def delete_item item
    return false if !contains? item
    if @contains.member? item
      @contains.delete item
      return true
    end
    !!@contains.find { |inner_item| inner_item.delete_item item }
  end
end
