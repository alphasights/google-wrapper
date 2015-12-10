# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'google/wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = "google-wrapper"
  spec.version       = Google::Wrapper::VERSION
  spec.authors       = ["John Bohn"]
  spec.email         = ["jjbohn@gmail.com"]
  spec.summary       = %q{Small gem to wrap google-api-client}
  spec.description   = %q{google-api-client can be a bit gnarly to work with sometimes. This makes things easier for us}
  spec.homepage      = "https://engineering.alphasights.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "google-api-client", "~> 0.8.6"
  spec.add_development_dependency "dotenv", "~> 2.0"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4.0"
end
