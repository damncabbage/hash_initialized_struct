# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hash_initialized_struct/version'

Gem::Specification.new do |spec|
  spec.name          = "hash_initialized_struct"
  spec.version       = HashInitializedStruct::VERSION
  spec.authors       = ["Rob Howard"]
  spec.email         = ["rob@robhoward.id.au"]
  spec.summary       = %Q{Struct, except it takes a Hash on object initialization.}
  spec.description   = %Q{Struct, except it takes a Hash on object initialization.\nclass Point < HashInitializedStruct.new(:x, :y); end; Point.new(x: 1, y: 2)}
  spec.homepage      = "https://github.com/damncabbage/hash_initialized_struct"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end
