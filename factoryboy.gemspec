# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'factoryboy/version'

Gem::Specification.new do |spec|
  spec.name          = "factoryboy"
  spec.version       = FactoryBoy::VERSION
  spec.authors       = ["Łukasz Odziewa"]
  spec.email         = ["lukasz.odziewa@gmail.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"
end
