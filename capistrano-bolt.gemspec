# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/bolt/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-bolt"
  spec.version       = Capistrano::Bolt::VERSION
  spec.authors       = ["Shankar Dhanasekaran"]
  spec.email         = ["shankar@opendrops.com"]
  spec.summary       = %q{Heroku-like easy deployment for Rails 4 with Capistrano 3, Puma, Nginx and Postgresql.}
  spec.description   = %q{Heroku-like easy deployment for Rails 4 with Capistrano 3, Puma, Nginx and Postgresql.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'capistrano', '~> 3.0'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
