# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open_vidu/version'

Gem::Specification.new do |spec|
  spec.name          = 'openvidu-ruby-client'
  spec.version       = OpenVidu::VERSION
  spec.authors       = ['Bryan Saxon']
  spec.email         = ['emailBryanSaxon@gmail.com']

  spec.summary       = 'OpenVidu Ruby client.'
  spec.description   = "Ruby client built around OpenVidu's REST API."
  spec.homepage      = 'https://github.com/BryanSaxon/openvidu-ruby-client'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/BryanSaxon/openvidu-ruby-client'
    spec.metadata['changelog_uri'] = 'https://github.com/BryanSaxon/openvidu-ruby-client'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'byebug', '~> 9.0', '>= 9.0.6'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'test-unit', '~> 3.3', '>= 3.3.4'

  spec.add_runtime_dependency 'dotenv', '~> 2.7', '>= 2.7.5'
  spec.add_runtime_dependency 'httparty', '~> 0.13.7'
end
