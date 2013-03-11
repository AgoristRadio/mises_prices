# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'MisesPrices/version'

Gem::Specification.new do |spec|
  spec.name          = "mises_prices"
  spec.version       = MisesPrices::VERSION
  spec.authors       = ["Hiro White"]
  spec.email         = ["hiro@agoristradio.com"]
  spec.description   = %q{Lookup Market Price Information}
  spec.summary       = %q{Bitcoin, Gold, etc.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency 'rb-inotify', '~> 0.8.8'

  spec.add_dependency "httparty" # gem dep
  spec.add_dependency "socksify" # gem dep
end
