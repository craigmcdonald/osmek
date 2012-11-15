# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'osmek/version'

Gem::Specification.new do |gem|
  gem.name          = "osmek"
  gem.version       = Osmek::Version
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Michele Gerarduzzi"]
  gem.email         = ["michele.gerarduzzi@gmail.com"]
  gem.description   = %q{A Ruby interface to the Osmek API.}
  gem.summary       = gem.description
  gem.homepage      = "http://github.com/michelegera/osmek"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'dotenv'

  gem.add_dependency 'faraday', '~> 0.8'
  gem.add_dependency 'yajl-ruby', '~> 1.1'
  gem.add_dependency 'hashie', '~> 1.2'
end
