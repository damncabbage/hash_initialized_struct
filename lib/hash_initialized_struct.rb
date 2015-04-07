require "hash_initialized_struct/version"

# class Point < HashInitializedStruct(:x, :y); end
# Or: Point = HashInitializedStruct(:x, :y)
#
# point  = Point.new(x: 1, y: 2)
# point.x # => 1
#
# point2 = Point.new(x: 1, y: 2, nonsense: "foobar")
# # => raises ArgumentError
class HashInitializedStruct
  class << self
    alias :subclass_new :new
  end

  def self.new(*attrs)
    symbol_attrs = attrs.map do |a|
      case a
      when Symbol
        a
      else
        a.to_sym.tap do |sym|
          raise TypeError, "Could not coerce #{a.inspect} to symbol" unless sym.kind_of?(Symbol)
        end
      end
    end

    Class.new self do
      const_set :STRUCT_ATTRS, symbol_attrs
      attr_accessor *symbol_attrs

      def self.new(*args, &block)
        self.subclass_new(*args, &block)
      end

      def initialize(attrs)
        provided = attrs.keys
        needed   = self.class::STRUCT_ATTRS
        (provided - needed).tap do |unknown|
          raise ArgumentError, "Unrecognised keys: #{unknown.map(&:inspect).join(', ')}" unless unknown.empty?
        end
        (needed - provided).tap do |missing|
          raise ArgumentError, "Missing keys: #{missing.map(&:inspect).join(', ')}" unless missing.empty?
        end
        attrs.each do |attr,value|
          instance_variable_set("@#{attr}", value)
        end
      end

      def to_h
        # [k,k,...] => [[k,v], [k,v], ...] => {k => v, k => v, ...}
        Hash[ self.class::STRUCT_ATTRS.map {|key| [key, self.public_send(key)]} ]
      end
      alias :to_hash :to_h
    end
  end
end
