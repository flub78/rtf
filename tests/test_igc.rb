#!/usr/bin/env ruby
require 'minitest/autorun'
require "igc"

# Trig module unit test
class TestSet < MiniTest::Test
  def setup
    @igc = Igc.new()
  end

  def test_basic
    @igc.load("485_UP.igc")
    assert(@igc, "Reader created")
    
    # @igc.display
    @igc.process()
    
  end
    
 
end