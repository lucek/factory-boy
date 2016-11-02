require 'spec_helper'
require 'factoryboy'

class User
  attr_accessor :name
  attr_accessor :admin
end

describe Factoryboy do
  describe "#define_factory" do
    context "user has not passed class when defining a factory" do
      before :each do
        Factoryboy.define_factory(:user)
      end

      it "should define factory for a given class" do
        expect(Factoryboy.instance_variable_get(:@defined_factories)).to include(:user)
      end
    end

    context "user has passed class when defining a factory" do
      before :each do
        Factoryboy.define_factory(:user, class: User)
      end

      it "should define factory for a given class" do
        expect(Factoryboy.instance_variable_get(:@defined_factories)).to include(:user)
      end
    end

    context "user has passed block when defining a factory" do
      before :each do
        Factoryboy.define_factory(:user, class: User) do
          name "foo"
          admin true
        end
      end

      it "should define factory for a given class" do
        expect(Factoryboy.instance_variable_get(:@defined_factories)).to include(:user)
      end
    end
  end

  describe "#build" do
    context "factory has already been defined" do
      context "user has not passed block when defining factory" do
        before :each do
          Factoryboy.define_factory(:user)
        end

        context "user hasn't passed any attributes to the build method" do
          it "should return new class instance with standard attributes" do
            object = Factoryboy.build(:user)
            expect(object).to be_a(User)
          end
        end

        context "user has passed attributes to the build method" do
          it "should return new class instance with passed attributes" do
            object = Factoryboy.build(:user, { name: "foo" })
            expect(object).to be_a(User)
            expect(object.name).to eql("foo")
          end
        end
      end

      context "user has passed block when defining factory" do
        before :each do
          Factoryboy.define_factory(:user) do
            name "bar"
          end
        end

        context "user hasn't passed any attributes to the build method" do
          it "should return new class instance with passed attributes" do
            object = Factoryboy.build(:user)
            expect(object).to be_a(User)
            expect(object.name).to eql("bar")
          end
        end

        context "user has passed attributes to the build method" do
          it "should return new class instance with passed attributes" do
            object = Factoryboy.build(:user, { name: "foo" })
            expect(object).to be_a(User)
            expect(object.name).to eql("foo")
          end
        end
      end

      context "user has passed class when defining factory" do
        before :each do
          Factoryboy.define_factory(:test, class: User)
        end

        it "should return new class instance" do
          object = Factoryboy.build(:test)
          expect(object).to be_a(User)
        end
      end

      context "user has not passed class when defining factory" do
        before :each do
          Factoryboy.define_factory(:user)
        end

        it "should return new class instance" do
          object = Factoryboy.build(:test)
          expect(object).to be_a(User)
        end
      end
    end

    context "factory has not been defined yet" do
      before :each do
        Factoryboy.instance_variable_set(:@defined_factories, {})
      end

      it "should raise FactoryNotDefined" do
        expect { Factoryboy.build(User) }.to raise_error(FactoryNotDefinedError)
      end
    end
  end
end
