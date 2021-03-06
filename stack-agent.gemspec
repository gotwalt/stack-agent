# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stack-agent'

Gem::Specification.new do |gem|
  gem.name          = 'stack-agent'
  gem.version       = StackAgent::VERSION
  gem.authors       = ['Aaron Gotwalt']
  gem.email         = ['gotwalt@gmail.com']
  gem.description   = 'Registers development stacks on stack'
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/gotwalt/stack-agent'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'thor', '~> 0'
  gem.add_dependency 'rest-client', '~> 1.5'
end
