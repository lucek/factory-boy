require 'spec_helper'
require 'factoryboy'

class User
  attr_accessor :name
  attr_accessor :admin
end

describe FactoryBoy do
  before :each do
    FactoryBoy.instance_variable_set(:@defined_factories, {})
  end

  describe "#define_factory" do
    context "user has passed name that does not map to any class name" do
      it "should raise UnknownClassError" do
        expect { FactoryBoy.define_factory(:non_existing_class) }.to raise_error(UnknownClassError)
      end
    end

    context "user has not passed class when defining a factory" do
      before :each do
        FactoryBoy.define_factory(:user)
      end

      it "should define factory for a given class" do
        expect(FactoryBoy.instance_variable_get(:@defined_factories)).to include(:user)
      end
    end

    context "user has passed class when defining a factory" do
      before :each do
        FactoryBoy.define_factory(:user, class: User)
      end

      it "should define factory for a given class" do
        expect(FactoryBoy.instance_variable_get(:@defined_factories)).to include(:user)
      end
    end

    context "user has passed block when defining a factory" do
      before :each do
        FactoryBoy.define_factory(:user, class: User) do
          name "foo"
        end
      end

      it "should define factory for a given class" do
        expect(FactoryBoy.instance_variable_get(:@defined_factories)).to include(:user)
      end
    end
  end

  describe "#build" do
    context "factory has already been defined" do
      context "user has not passed block when defining factory" do
        before :each do
          FactoryBoy.define_factory(:user)
        end

        context "user hasn't passed any attributes to the build method" do
          it "should return new class instance with standard attributes" do
            object = FactoryBoy.build(:user)
            expect(object).to be_a(User)
          end
        end

        context "user has passed attributes to the build method" do
          before :all do
            @object = FactoryBoy.build(:user, { name: "foo" })
          end

          it "should return new correct class instance" do
            expect(@object).to be_a(User)
          end

          it "instance should have correct attributes set" do
            expect(@object.name).to eql("foo")
          end
        end
      end

      context "user has passed block when defining factory" do
        before :each do
          FactoryBoy.define_factory(:user) do
            name "bar"
            admin true
          end
        end

        context "user hasn't passed any attributes to the build method" do
          before :each do
            @object = FactoryBoy.build(:user)
          end

          it "should return new correct class instance" do
            expect(@object).to be_a(User)
          end

          it "instance should have name attribute set" do
            expect(@object.name).to eql("bar")
          end

          it "instance should have admin attribute set" do
            expect(@object.admin).to be true
          end
        end

        context "user has passed attributes to the build method" do
          before :each do
            @object = FactoryBoy.build(:user, { name: "foo", admin: false })
          end

          it "should return new class instance with passed attributes" do
            expect(@object).to be_a(User)
          end

          it "instance should have default name attribute overwritten" do
            expect(@object.name).to eql("foo")
          end

          it "instance should have default admin attribute overwritten" do
            expect(@object.admin).to be false
          end
        end
      end
    end

    context "factory has not been defined yet" do
      it "should raise FactoryNotDefined" do
        expect { FactoryBoy.build(User) }.to raise_error(FactoryNotDefinedError)
      end
    end
  end
end
