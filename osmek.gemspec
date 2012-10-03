# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'osmek/version'

Gem::Specification.new do |gem|
  gem.name          = "osmek"
  gem.version       = Osmek::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Michele Gerarduzzi"]
  gem.email         = ["michele.gerarduzzi@gmail.com"]
  gem.description   = %q{Ruby library for Osmek Content APIs}
  gem.summary       = %q{Ruby library for Osmek Content APIs}
  gem.homepage      = "http://github.com/michelegera/osmek"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
