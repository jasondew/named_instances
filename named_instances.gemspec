require File.expand_path("../lib/named_instances/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "named_instances"
  s.version     = NamedInstances::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jason Dew"]
  s.email       = ["jason.dew@gmail.com"]
  s.homepage    = "http://github.com/jasondew/named_instances"
  s.summary     = "Model.get(:name)"
  s.description = "Give cached access to ActiveRecord models for quicker and more readable data-based logic."

  s.required_rubygems_version = ">= 1.3.6"

  # lol - required for validation
  s.rubyforge_project         = "named_instances"

  # If you have other dependencies, add them here
  # s.add_dependency "another", "~> 1.2"

  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'

  # If you need an executable, add it here
  # s.executables = ["named_instances"]

  # If you have C extensions, uncomment this line
  # s.extensions = "ext/extconf.rb"
end
