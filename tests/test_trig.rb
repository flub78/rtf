#!/usr/bin/env ruby
require 'minitest/autorun'
require "trig.rb"

# Trig module unit test
class TestTrig < MiniTest::Test
  def setup
  end

  def test_trig_0
    angle = 0
    delta = 1e-9
    
    assert_equal(0, Trig.sin(angle))
    assert_equal(1, Trig.cos(angle))
    assert_in_delta(1, Trig.sin(angle) * Trig.sin(angle) + Trig.cos(angle) * Trig.cos(angle), delta)
      
    angle = Trig::PI / 2;
    puts "Trig.sin(#{angle}) = #{Trig.sin(angle)}"
    assert_equal(1, Trig.sin(angle))
    assert_in_delta(0, Trig.cos(angle), delta)
    assert_in_delta(1, Trig.sin(angle) * Trig.sin(angle) + Trig.cos(angle) * Trig.cos(angle), delta)
  end

 
end