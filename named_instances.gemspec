# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "named_instances/version"

Gem::Specification.new do |s|
  s.name        = "named_instances"
  s.version     = NamedInstances::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jason Dew"]
  s.email       = ["jason.dew@gmail.com"]
  s.homepage    = "http://github.com/jasondew/named_instances"
  s.summary     = "Model.get(:name)"
  s.description = "Give cached access to ActiveRecord models for quicker and more readable data-based logic."

  s.rubyforge_project = "named_instances"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activesupport"
  s.add_dependency "i18n"

  s.add_development_dependency "thoughtbot-shoulda"
  s.add_development_dependency "mocha"
  s.add_development_dependency "sqlite3-ruby"
end
