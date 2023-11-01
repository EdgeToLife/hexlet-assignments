# frozen_string_literal: true

# BEGIN
module Init
  def attribute(name, options = {})
    type = options[:type] || nil
    define_method "#{name}=" do |value|
      self.instance_variable_set "@#{name}", value
      @attr.merge!("#{name}".to_sym => value)
    end
    define_method "#{name}" do
      self.instance_variable_get "@#{name}"
      value = instance_variable_get("@#{name}")
      value = convert(value, type) if type
      value
    end
  end
end

module Model
  def self.included(base)
    base.extend Init
  end

  def initialize (attr_hash = {})
    @attr = {}
    update(attr_hash)
  end

  def update(attr_hash)
    attr_hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def convert(value, type)
    if type == :string
      value.to_s
    elsif type == :integer
      value.to_i
    elsif type == :datetime
      DateTime.parse(value)
    elsif type == :boolean
      value == true || value == "true"
    else
      value
    end
  end

  def attributes
    result = {}
    @attr.each do |key, value|
      result = result.merge(key.to_sym => send("#{key}"))
    end
    result
  end
end
# END
