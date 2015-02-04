require 'hash_initialized_struct'

describe "HashInitializedStruct" do
  let(:klass) { HashInitializedStruct.new(:x, :y) }

  it "creates a struct class that accepts initializing values via a Hash" do
    point = klass.new(x: 1, y: 2)
    expect(point.x).to eq 1
    expect(point.y).to eq 2
  end

  it "creates a struct class that extends from HashInitializedStruct" do
    expect(klass < HashInitializedStruct).to eq true
  end

  it "allows mutation of attributes" do
    point = klass.new(x: 1, y: 2)
    expect(point.x).to eq 1
    point.x = 5
    expect(point.x).to eq 5
  end

  it "disallows unrecognised keys" do
    expect {
      point = klass.new(x: 1, y: 2, z: 3)
    }.to raise_error(ArgumentError, "Unrecognised keys: :z")
    expect {
      point = klass.new(x: 1, y: 2, self => "u wot")
    }.to raise_error(ArgumentError, /Unrecognised keys: #<RSpec.*>/)
  end

  it "disallows creation with missing keys" do
    expect {
      point = klass.new(x: 1)
    }.to raise_error(ArgumentError, "Missing keys: :y")
  end

  it "allows for overriding the constructor to add additional checks" do
    # Could do this with an anonymous class and define_method, but we're trying to emulate
    # how it might actually be used.
    class My3DPoint < HashInitializedStruct.new(:x, :y, :z)
      def initialize(attrs)
        super
        [x, y, z].each do |attr|
          raise ArgumentError, "#{attr} must be a number" unless attr.kind_of?(Numeric)
        end
      end
    end

    good = My3DPoint.new(x: 1, y: 2, z: 9)
    expect(good.x).to eq 1

    expect {
      My3DPoint.new(x: "1", y: nil, z: 9)
    }.to raise_error(ArgumentError)
  end
end
