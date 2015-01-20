
require_relative "../data/assets.rb"

class Player

  attr_reader :location, :health, :messages, :inventory, :weapon
	attr_writer :godly

  def initialize
    @location = Assets::get_location :front_gate
    @health = 10
    @messages = []
    @inventory = []
    @godly = false
  end

  def do_environmental_effect
    return if @godly
    @location.environmental_effect.run self
  end

  def take_damage amount, message
  	return if @godly
    @messages << "#{message} (#{amount} damage)"
    @health = [0, @health - amount].max
  end

  def clear_messages
    @messages = []
  end

  def dead?
    @health <= 0
  end

  def go direction
    if !@location.entities.empty? && !@godly
      @messages << "An entity here won't let you leave!"
      return
    end

    direction = :ground if direction == :down
    direction = :ceiling if direction == :up

    desired_location = @location.paths[direction]

    if desired_location.nil?
      notify "You can't go that way."
      return
    end

    if @location.blocked?(direction) && !@godly
      notify "The way is blocked by the #{@location.items[direction].name}."
      return
    end

    @location = desired_location
  end

  def can_reach_item? item
    return @location.contains?(item) || @inventory.member?(item) || (@weapon == item) || @godly
  end

  def notify message
    messages << message
  end

  def is_holding? item
    @inventory.member? item
  end

  def hold item
    @inventory << item
  end

  def use_up item
    if @location.items.value? item
      @location.delete_item item
      return
    end

    if @inventory.member? item
      @inventory.delete item
      return
    end
  end

  def heal amount
    notify "You gain #{amount} HP."
    @health = [10, @health + amount].min
  end

  def equip item
    if item.is_weapon
      hold @weapon if !@weapon.nil?
      @weapon = item
      use_up item
      notify "You have equipped #{item.determined_name}."
    end
  end

	def godly?
		@godly
	end
end
