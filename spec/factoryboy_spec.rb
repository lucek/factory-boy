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

  describe "#build" do
    context "factory has already been defined" do
      before :each do
        Factoryboy.define_factory(User)
      end

      context "user hasn't passed any attributes to the build method" do
        it "should return new class instance with standard attributes" do
          object = Factoryboy.build(User)
          expect(object).to be_a(User)
        end
      end

      context "user has passed attributes to the build method" do
        it "should return new class instance with passed attributes" do
          object = Factoryboy.build(User, { name: "foo" })
          expect(object).to be_a(User)
          expect(object.name).to eql("foo")
        end
      end
    end

    context "factory has not been defined yet" do
      before :each do
        Factoryboy.instance_variable_set(:@defined_factories, [])
      end

      it "should raise FactoryNotDefined" do
        expect { Factoryboy.build(User) }.to raise_error(FactoryNotDefinedError)
      end
    end
  end
end
