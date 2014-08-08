#!/usr/bin/env ruby
require 'minitest/autorun'
require "coordinate"

# Trig module unit test
class TestSet < MiniTest::Test
  def setup
    @set1 = Coordinate.new()
  end

  def test_basic
    assert(@set1, "Set created")
  end
     
end