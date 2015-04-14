#!/usr/bin/env ruby

gem "minitest"

require 'minitest/autorun'
require 'HexString.rb'

# Simple example of sqlite access
class TestAssert < MiniTest::Test
  
  def setup
  end

  def test_basic
	 assert(1 == 1, "1 == 1 is true")
  end
  
  def teardown
  end
     
end