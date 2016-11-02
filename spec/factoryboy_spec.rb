require 'spec_helper'
require 'factoryboy'

class User
  attr_accessor :name
end

describe Factoryboy do
  describe "#define_factory" do
    it "should define factory for a given class" do
      Factoryboy.define_factory(User)
      expect(Factoryboy.instance_variable_get(:@defined_factories)).to include(User)
    end
  end
end
