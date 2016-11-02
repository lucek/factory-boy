require "factoryboy/version"

module Factoryboy
  @defined_factories = []

  def self.define_factory(klass)
    @defined_factories << klass
  end
end
