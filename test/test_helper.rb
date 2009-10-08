require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'rails_crutch'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'fixtures'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'named_instances'
require 'diagnosis'

class Test::Unit::TestCase
end
