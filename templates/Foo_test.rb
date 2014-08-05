#!/usr/bin/env ruby
# Empty Ruby script
#
# This script:
# * analyses its arguments
# * Desiplay an onlye help if --help or -h are recognised
# * Log some information
# * exit
#
# Author::    Frédéric  (mailto:fpeignot@x.y)

require 'minitest/autorun'
require "./Foo"

class UnitTest < MiniTest::Test
  
  def setup
    @name = "joe"
    @instance = Foo.new(:bar => 42)
    @instance_with_default = Foo.new()
    
  end

  def test_default
    assert(@instance, "@instance created")
    assert(@instance_with_default, "@instance_with_default created")

    assert_equal(42, @instance.bar(), "Attribute initialized by constructor")
    @instance.bar = 13
    assert_equal(13, @instance.bar(), "Attribute modified bu setter")

    assert_equal(nil, @instance_with_default.bar(), "Default attribute")
    
  end

end
