# FactoryBoy

Simple, FactoryGirl inspired gem written for ToopLoox coding challenge

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'factoryboy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install factoryboy

## Usage examples

```ruby
FactoryBoy.define_factory(:user) do
  name "foobar"
end

FactoryBoy.build(:user) # => #<User:0x007fb98492834 @name="foobar">
```

```ruby
FactoryBoy.define_factory(:admin, class: User) do
  name "foobar"
  admin true
end

FactoryBoy.build(:admin) # => #<User:0x007fb98492834 @name="foobar" @admin=true>
```
