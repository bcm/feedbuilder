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
  s.summary     = %q{An easier way to build Atom feeds}
  s.description =
    %q{A utility that simplifies the process of building Atom feeds from collections of well-behaved objects}

  s.rubyforge_project = "feedbuilder"

  s.add_dependency 'activesupport', '~> 3.0'
  s.add_dependency 'ratom'
  s.add_development_dependency 'rspec', '~> 2.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
