# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-tar-files'
  spec.version       = '0.0.8'
  spec.authors       = ['Andy Palmer']
  spec.email         = ['andy@andypalmer.me']
  spec.description   = %q{Create/unpack tarball archives during deployment}
  spec.summary       = %q{Create/unpack tarball archives for directories that don't change often like vendor and node_modules}
  spec.homepage      = 'https://github.com/andyexeter/capistrano-tar-files'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'capistrano', '~> 3.0', '>= 3.0.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 0'
end
