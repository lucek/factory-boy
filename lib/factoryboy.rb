module FactoryBoy
  @defined_factories = {}

  def self.define_factory(name, opts={}, &block)
    raise UnknownClassError unless Object.const_defined?(name.to_s.split('_').collect(&:capitalize).join)

    built_factory = FactoryBuilder.new(block, opts[:class])
    @defined_factories[name] = built_factory
  end

  def self.build(name, attributes={})
    raise FactoryNotDefinedError unless @defined_factories.keys.include?(name)

    defined_factory = @defined_factories[name]
    defined_class   = defined_factory.instance_variable_get(:@class)
    klass = defined_class ? defined_class : Object.const_get(name.to_s.split('_').collect(&:capitalize).join)

    object = klass.new
    defined_factory.evaluate(object)

    if !attributes.empty?
      attributes.each do |k,v|
        object.send("#{k}=", v)
      end
    end

    return object
  end
end

class FactoryBuilder
  def initialize(block, klass)
    @block = block
    @class = klass
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

class UnknownClassError < StandardError
end

class FactoryNotDefinedError < StandardError
end
