# frozen_string_literal: true

require_relative 'lib/tailwind_views_generator/version'

Gem::Specification.new do |spec|
  spec.name          = 'tailwind_views_generator'
  spec.version       = TailwindViewsGenerator::VERSION
  spec.authors       = ['Brandon Hicks']
  spec.email         = ['tarellel@gmail.com']

  spec.summary       = 'TailwindCSS generators for overwriting the default Rails view generators'
  spec.description   = 'A Rails based generator for creating TailwindCSS based Views/layouts for for your application'
  spec.homepage      = 'https://github.com/tarellel/tailwind_views_generator'
  spec.license       = 'MIT'
  spec.required_ruby_version = ">= #{TailwindViewsGenerator::MIN_RUBY_VERSION}"


  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = spec.homepage
    spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'railties', '>= 4.0'
  spec.add_development_dependency 'bundler', '>= 1.17', '<= 3'
  spec.add_development_dependency 'rake', '>= 7.0', '<= 20.0'
end
