# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'okyakusan/version'

Gem::Specification.new do |spec|
  spec.name          = "okyakusan"
  spec.version       = Okyakusan::VERSION
  spec.authors       = ["Terence Lee"]
  spec.email         = ["hone02@gmail.com"]
  spec.summary       = %q{Wrapper Around net/http to be used with Heroku API V3}
  spec.description   = %q{Wrapper Around net/http to be used with Heroku API V3}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "netrc", "~> 0.7.7"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
