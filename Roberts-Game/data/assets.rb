
require 'yaml'

require_relative "../models/EnvironmentalEffect"
require_relative "../models/Item"
require_relative "../models/Location"
require_relative "../models/Entity"

require_relative "EnvironmentalEffectProxy"
require_relative "ItemProxy"
require_relative "LocationProxy"
require_relative "EntityProxy"

module Assets
  @instanced = nil
  @raw = nil

  def self.get_location name
    check_loaded
    return nil if @raw[:locations][name].nil?
    @instanced[:locations][name] = LocationProxy.new @raw[:locations][name] if @instanced[:locations][name].nil?
    return @instanced[:locations][name]
  end

  def self.get_environmental_effect name
    check_loaded
    return nil if @raw[:environmental_effects][name].nil?
    @instanced[:environmental_effects][name] = EnvironmentalEffectProxy.new @raw[:environmental_effects][name] if @instanced[:environmental_effects][name].nil?
    return @instanced[:environmental_effects][name]
  end

  def self.get_item name
    check_loaded
    return nil if @raw[:items][name].nil?
    @instanced[:items][name] = ItemProxy.new name, @raw[:items][name] if @instanced[:items][name].nil?
    return @instanced[:items][name]
  end

  def self.get_entity name
    check_loaded
    return nil if @raw[:entities][name].nil?
    @instanced[:entities][name] = EntityProxy.new name, @raw[:entities][name] if @instanced[:entities][name].nil?
    return @instanced[:entities][name]
  end

  def self.get_string name
    check_loaded
    @raw[:strings][name]
  end

  private

  def self.check_loaded
    load if !@raw
  end

  def self.load
    working_dir = File.dirname(File.expand_path(__FILE__))
    @raw = {
      locations: YAML::load_file(File.join(working_dir, 'locations.yml')),
      environmental_effects: YAML::load_file(File.join(working_dir, 'environmental_effects.yml')),
      items: YAML::load_file(File.join(working_dir, 'items.yml')),
      strings: YAML::load_file(File.join(working_dir, 'strings.yml')),
      entities: YAML::load_file(File.join(working_dir, 'entities.yml'))
    }

    @raw[:items] = symbolize @raw[:items], :unlocks_with, :contains
    @raw[:entities] = symbolize @raw[:entities], :drops, :weakness
    @raw[:environmental_effects] = symbolize @raw[:environmental_effects]
    @raw[:locations] = symbolize @raw[:locations], :environmental_effect, :paths, :items, :entities
    @raw[:strings] = symbolize @raw[:strings]

    @instanced = {
      locations: {},
      environmental_effects: {},
      items: {},
      entities: {}
    }
  end

  def self.symbolize dataset, *symbols
    result = {}
    dataset.each do |data_key, data|
      data_key = data_key.to_sym
      if data.is_a? String
        result[data_key] = data
      else
        new_data = {}
        data.each do |key, value|
          key = key.to_sym

          if symbols.member? key
            case value
            when Array
              value.map! { |val| val.to_sym }
            when Hash
              new_value = {}
              value.each { |k,v| new_value[k.to_sym] = v.to_sym }
              value = new_value
            when NilClass
              # don't attempt to modify
            else
              value = value.to_sym
            end
          end
          new_data[key] = value
        end
        result[data_key] = new_data
      end
    end
    return result
  end
end
