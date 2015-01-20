
class ItemProxy
  def initialize sym, data
    @sym = sym
    @raw = data
  end

  def name
    target.name
  end

  def description
    target.description
  end

  def determiner
    target.determiner
  end

  def blocking?
    target.blocking?
  end

  def unlock_with item
    target.unlock_with item
  end

  def takeable
    target.takeable
  end

  def determined_name
    target.determined_name
  end

  def contains
    target.contains
  end

  def contains? item
    target.contains? item
  end

  def delete_item item
    target.delete_item item
  end

  def is_food
    target.is_food
  end

  def hp_bonus
    target.hp_bonus
  end

  def is_weapon
    target.is_weapon
  end

  def weapon_damage
    target.weapon_damage
  end

  def easy_to_read
    target.easy_to_read
  end

  def text
    target.text
  end

  private

  def target
    @target = Item.new @sym, @raw if @target.nil?
    return @target
  end
end
