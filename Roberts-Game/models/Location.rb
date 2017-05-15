
require_relative "../data/assets"

class Location
  attr_reader :short_description, :long_description, :paths, :environmental_effect, :items, :entities

  def initialize data
    @short_description = data[:short_description]
    @long_description = data[:long_description]
    @environmental_effect = data[:environmental_effect] || :none
    @paths = data[:paths] || {}
    @items = data[:items] || {}
    @entities = (data[:entities] || []).map { |sym| Assets::get_entity sym }

    @environmental_effect = Assets::get_environmental_effect @environmental_effect
    @paths.each { |key,sym| @paths[key] = Assets::get_location sym }
    @items.each { |key,sym| @items[key] = Assets::get_item sym }
  end

  def blocked? direction
    return false if @items[direction].nil?
    @items[direction].blocking?
  end

  def delete_item item
    return false if !contains? item
    if @items.value? item
      @items.delete @items.key item
      return true
    end
    !!@items.find { |key, inner_item| inner_item.delete_item item }
  end

  def delete_entity entity
    @entities.delete entity
  end

  def contains? item
    return true if @items.value? item
    !!@items.find { |key, inner_item| inner_item.contains? item }
  end

  def tick player
    @entities.reject! { |entity| entity.dead? }
    @entities.each { |entity| entity.tick player }
  end
end
