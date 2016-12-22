#!/usr/bin/env ruby
# Basic class unit test
# Author::    Frédéric  (mailto:fpeignot@x.y)

gem "minitest"
require 'minitest/autorun'
require "./Foo"

class UnitTest < MiniTest::Test
  
  def setup
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
    
    @instance.hello("Fred")
  end

end
