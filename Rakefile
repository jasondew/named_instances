require "bundler"
Bundler::GemHelper.install_tasks

task :default => :test

desc "Run the tests"
task :test do
  system "ruby -Itest test/named_instances_test.rb"
end
