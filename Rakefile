require "bundler"
Bundler.setup

task :default => :test

require "rake/testtask"
Rake::TestTask.new(:test) do |test|
  test.libs << "lib" << "test"
  test.pattern = "test/**/*_test.rb"
  test.verbose = true
end

gemspec = eval(File.read("named_instances.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["named_instances.gemspec"] do
  system "gem build named_instances.gemspec"
  system "gem install named_instances-#{NamedInstances::VERSION}.gem"
end
