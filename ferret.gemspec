
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ferret/version'

Gem::Specification.new do |spec|
  spec.name          = 'ferret'
  spec.version       = Ferret::VERSION
  spec.authors       = ['Michael Miller']
  spec.email         = ['icy.arctic.fox@gmail.com']

  spec.summary       = 'Git repository analyzer - automatically scans new commits and generates reports'
  spec.homepage      = 'https://github.com/icy-arctic-fox/ferret'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rugged',   '~> 0.26'
  spec.add_dependency 'diff-lcs', '~> 1.3'
  spec.add_dependency 'thor',     '~> 0.20'
  spec.add_dependency 'haml',     '~> 5.0'

  spec.add_development_dependency 'bundler',     '~> 1.16'
  spec.add_development_dependency 'rake',        '~> 10.0'
  spec.add_development_dependency 'rspec',       '~> 3.0'
  spec.add_development_dependency 'factory_bot', '~> 4.8'
end
