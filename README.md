# Hash-Initialized Struct [![Build Status](https://travis-ci.org/damncabbage/hash_initialized_struct.svg)](https://travis-ci.org/damncabbage/hash_initialized_struct)

Halfway between Struct and OpenStruct. (Or: Struct, except it takes a Hash on object initialization.)

Ignore if you already use [Virtus](https://github.com/solnic/virtus) or [Hashie::Dash](https://github.com/intridea/hashie).


## Usage

```ruby
class Point < HashInitializedStruct.new(:x, :y); end
# Or: Point = HashInitializedStruct.new(:x, :y)

point = Point.new(x: 1, y: 2)
point.x # => 1

unknowns = Point.new(x: 1, y: 2, z: 3)
# => raises ArgumentError, "Unrecognised keys: :z"

missing = Point.new(x: 1)
# => raises ArgumentError, "Missing keys: :y"
```

### Fancy Usage

```ruby
class Point < HashInitializedStruct.new(:x, :y)
  def initialize(attrs)
    super
    [x, y].each do |attr|
      raise ArgumentError, "#{attr} must be a number" unless attr.kind_of?(Numeric)
    end
  end
end

good = Point.new(x: 1, y: 2)
good.x # => 1

bad = Point.new(x: "1", y: nil)
# => raises ArgumentError, "x must ..."
```


### Fancier Usage

Stop. Go use [Virtus](https://github.com/solnic/virtus).


## Installation

Add the following to your application's Gemfile:

```ruby
gem 'hash_initialized_struct'
```

And then run `bundle install`.


## Contributing

1. Fork it ( https://github.com/damncabbage/hash_initialized_struct/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

See LICENSE.txt
