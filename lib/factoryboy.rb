module Factoryboy
  @defined_factories = {}

  def self.define_factory(klass, &block)
    attributes = AttributeBuilder.new(block)
    @defined_factories[:"#{klass}"] = AttributeBuilder.new(block)
  end

  def self.build(klass, attributes={})
    klass_symbol = klass.to_s.to_sym
    raise FactoryNotDefinedError unless @defined_factories.keys.include?(klass_symbol)

    object = klass.new
    @defined_factories[klass_symbol].evaluate(object)

    if !attributes.empty?
      attributes.each do |k,v|
        object.send("#{k}=", v)
      end
    end

    return object
  end
end

class AttributeBuilder
  def initialize(block)
    @block = block
  end

  def method_missing(method, *args, &block)
    @object.send("#{method}=", args.first)
  end

  def evaluate(object)
    if @block
      @object = object
      instance_eval(&@block)
    end
  end
end

class FactoryNotDefinedError < StandardError
end
