# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "feed-builder/version"

Gem::Specification.new do |s|
  s.name        = "feed-builder"
  s.version     = Feed::Builder::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brian Moseley"]
  s.email       = ["bcm@maz.org"]
  s.homepage    = ""
  s.summary     = %q{Feed building utilities for Rails}
  s.description = %q{Simplifies feed building for Rails models and controllers}

  s.rubyforge_project = "feed-builder"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
