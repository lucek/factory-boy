require "factoryboy/version"

module Factoryboy
  @defined_factories = []

  def self.define_factory(klass)
    @defined_factories << klass
  end

  def self.build(klass, attributes={})
    raise FactoryNotDefinedError unless @defined_factories.include?(klass)

    object = klass.new

    if !attributes.empty?
      attributes.each do |k,v|
        object.send("#{k}=", v)
      end
    end

    return object
  end
end

class FactoryNotDefinedError < StandardError
end
