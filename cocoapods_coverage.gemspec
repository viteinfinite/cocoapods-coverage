# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods_coverage.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-coverage'
  spec.version       = CocoapodsCoverage::VERSION
  spec.authors       = ['Boris Bügling']
  spec.email         = ['boris@bügling.com']
  spec.summary       = 'Generate code coverage statistics for Pods.'
  spec.homepage      = 'https://github.com/viteinfinite/cocoapods-coverage'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'cocoapods-testing', '>= 0.0.4'
  spec.add_dependency 'slather', '>= 1.6.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
