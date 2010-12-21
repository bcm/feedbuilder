# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "feedbuilder/version"

Gem::Specification.new do |s|
  s.name        = "feedbuilder"
  s.version     = FeedBuilder::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brian Moseley"]
  s.email       = ["bcm@maz.org"]
  s.homepage    = ""
  s.summary     = %q{Feed building utilities for Rails}
  s.description = %q{Simplifies feed building for Rails models and controllers}

  s.rubyforge_project = "feedbuilder"

  s.add_dependency 'actionpack', '~> 3.0'
  s.add_dependency 'activerecord', '~> 3.0'
  s.add_dependency 'ratom'
  s.add_development_dependency 'rspec', '~> 2.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
