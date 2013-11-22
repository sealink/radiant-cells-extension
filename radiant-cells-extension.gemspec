Gem::Specification.new do |spec|
  spec.name          = "radiant-cells-extension"
  spec.version       = '0.0.1'
  spec.authors       = ["Adam Davies, Michael Noack"]
  spec.email         = ["support@travellink.com.au"]
  spec.description   = %q{Radiant extension to use cells.}
  spec.summary       = %q{Radiant extension to use cells.}
  spec.homepage      = 'http://github.com/sealink/radiant-cells-extension'

  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency('cells', '<= 3.3.9') # anything higher is rails 3 specific
  spec.add_dependency('radius')

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency('rspec', '>= 2.0')
end
