
=begin

NOTE TO SELF - move string formatting stuff to view class/module
maybe make Message class and subclasses and let view sort it out?

=end

class Command
  def self.parse sentence
    rejections = %w(a an the)
    words = sentence.split.map(&:downcase).reject { |word| rejections.member? word }.map(&:to_sym)

    return UnknownCommand.new if words.empty?

    case words[0]
    when :exit, :quit
      return ExitCommand.new
    when :help
      return HelpCommand.new
    when :look
      return LookAroundCommand.new if words.length == 1
      if words[1] == :at && words.length > 2
        item = Assets::get_item words[2..-1].join('_').to_sym
        return DontSeeCommand.new words[2..-1].join(' ') if item.nil?
        return LookAtCommand.new item
      end
    when :go
      return UnknownCommand.new if words.length != 2
      case words[1]
      when :north, :south, :east, :west, :up, :down
        return GoCommand.new words[1]
      end
    when :unlock
      return UnknownCommand.new if words.length == 1
      with_index = words.index :with
      return UnknownCommand.new if with_index.nil?

      words_a = words[1...with_index]
      sym_a = words_a.join('_').to_sym
      item_a = Assets::get_item sym_a
      return DontSeeCommand.new words_a.join(' ') if item_a.nil?

      words_b = words[with_index + 1..-1]
      sym_b = words_b.join('_').to_sym
      item_b = Assets::get_item sym_b
      return DontSeeCommand.new words_b.join(' ') if item_b.nil?

      return UnlockWithCommand.new item_a, item_b
    when :take
      return UnknownCommand.new if words.length == 1
      item = Assets::get_item words[1..-1].join('_').to_sym
      return DontSeeCommand.new words[1..-1].join(' ') if item.nil?
      return TakeCommand.new item
    when :eat
      return UnknownCommand.new if words.length == 1
      item = Assets::get_item words[1..-1].join('_').to_sym
      return DontSeeCommand.new words[1..-1].join(' ') if item.nil?
      return DisplayMessageCommand.new "You can't eat #{item.determined_name}." if !item.is_food
      return ConsumeCommand.new item, "eat"
    when :equip
      return UnknownCommand.new if words.length == 1
      item = Assets::get_item words[1..-1].join('_').to_sym
      return DontSeeCommand.new words[1..-1].join(' ') if item.nil?
      return DisplayMessageCommand.new "You can't equip #{item.determined_name}." if !item.is_weapon
      return EquipCommand.new item
    when :read
      return UnknownCommand.new if words.length == 1
      item = Assets::get_item words[1..-1].join('_').to_sym
      return DontSeeCommand.new words[1..-1].join(' ') if item.nil?
      return DisplayMessageCommand.new "You can't read #{item.determined_name}." if !item.text
      return ReadCommand.new item
    when :attack
      return UnknownCommand.new if words.length == 1
      entity = Assets::get_entity words[1..-1].join('_').to_sym
      return DontSeeCommand.new words[1..-1].join(' ') if entity.nil?
      return AttackCommand.new entity
    end

    return UnknownCommand.new
  end

  def run player
  end
end

class UnknownCommand < Command; end
class ExitCommand < Command; end
class HelpCommand < Command; end
class LookAroundCommand < Command; end

class GoCommand < Command
  def initialize direction
    @direction = direction
  end

  def run player
    player.go @direction
  end
end

class UnlockWithCommand < Command
  def initialize item_a, item_b
    @item_a = item_a
    @item_b = item_b
  end

  def run player
    if !player.can_reach_item? @item_a
      DontSeeCommand.new(@item_a).run player
      return
    end

    if !player.can_reach_item? @item_b
      DontSeeCommand.new(@item_b).run player
      return
    end

    if @item_a.unlock_with @item_b
      player.notify "You have unlocked the #{@item_a.name} with the #{@item_b.name}."
      player.use_up @item_b
    else
      player.notify "The #{@item_b.name} does not unlock the #{@item_a.name}"
    end
  end
end

class DisplayMessageCommand
  def initialize message
    @message = message
  end

  def run player
    player.notify @message
  end
end

class TakeCommand
  def initialize item
    @item = item
  end

  def run player
    if !@item.takeable
      player.notify "You can't take #{@item.determined_name}."
      return
    end
    if !player.location.contains? @item
      DontSeeCommand.new(@item).run player
      return
    end
    player.location.delete_item @item
    player.hold @item
    player.notify "You took the #{@item.name}."
  end
end

class DontSeeCommand
  def initialize thing
    @thing = thing
  end

  def run player
    case @thing
    when String
      name = "any \"#{@thing}\""
    when Item, Entity
      name = @thing.determined_name
    else
      name = "that"
    end

    player.notify "I don't see #{name} near here."
  end
end

class LookAtCommand
  def initialize item
    @item = item
  end

  def run player
    contents = @item.contains.map { |inner_item| inner_item.determined_name }.join ", "
    contents = "Inside you see: " + contents if !contents.empty?
    player.notify "You look at the #{@item.name}. #{@item.description} #{contents}"
  end
end

class ConsumeCommand
  def initialize item, verb
    @item = item
    @verb = verb
  end

  def run player
    player.notify "You #{@verb} the #{@item.name}."
    player.heal @item.hp_bonus if !@item.hp_bonus.nil?
    player.use_up @item
  end
end

class EquipCommand
  def initialize item
    @item = item
  end

  def run player
    player.equip @item
  end
end

class AttackCommand
  def initialize entity
    @entity = entity
  end

  def run player
    if !player.location.entities.member? @entity
      DontSeeCommand.new(@entity).run player
      return
    end

    weapon_name = player.weapon.nil? ? "bare hands" : player.weapon.name
    damage_dealt = @entity.take_damage player.weapon
    player.notify "You attack the #{@entity.name} with your #{weapon_name} for #{damage_dealt} points."
    if @entity.dead?
      player.location.delete_entity @entity
      player.notify "You have defeated #{@entity.determined_name}!"
      if !!@entity.drops
        player.location.items[:ground] = @entity.drops
        player.notify "It dropped #{@entity.drops.determined_name}."
      end
    end
  end
end

class ReadCommand
  def initialize item
    @item = item
  end

  def run player
    text = "\"#{@item.text}\""
    text = jumble text if !@item.easy_to_read && player.location != Assets::get_location(:study)
    player.notify "The #{@item.name} reads: #{text}"
  end

  private

  def jumble text
    result = ""
    text.each_char do |char|
      if /[[:upper:]]/.match(char)
        result << [*'A'..'Z'].sample
      elsif /[[:lower:]]/.match(char)
        result << [*'a'..'z'].sample
      else
        result << char
      end
    end
    result << " (You are not clever enough to decipher this message.)"
    return result
  end
end
