#!/usr/bin/env ruby
require 'minitest/autorun'
require "igc"

# Trig module unit test
class TestSet < MiniTest::Test
  def setup
    @igc = Igc.new()
    
    @delta = 0.1
    @lat = 46.953466666666664
    @long = 0.14673333333333333
    
    h = 14
    m = 52
    s = 10
    dt = 1
    alt = 1000
    
    @point = Coordinate.new(:hour => h, :minute => m, :second => s,
      :latitude => @lat,
      :longitude => @long, :validity => 'A', :palt => alt, :alt => alt)
      
    @point_N = Coordinate.new(:hour => h, :minute => m, :second => s + dt,
      :latitude => @lat + @delta,
      :longitude => @long, :validity => 'A', :palt => alt + 1, :alt => alt + 1)

    @point_S = Coordinate.new(:hour => h, :minute => m, :second => s + 2 * dt,
      :latitude => @lat - @delta,
      :longitude => @long, :validity => 'A', :palt => alt + 1, :alt => alt + 1)

    @point_E = Coordinate.new(:hour => h, :minute => m, :second => s + dt,
      :latitude => @lat,
      :longitude => @long + @delta, :validity => 'A', :palt => alt + 1, :alt => alt + 1)

    @point_W = Coordinate.new(:hour => h, :minute => m, :second => s + dt,
      :latitude => @lat,
      :longitude => @long - @delta, :validity => 'A', :palt => alt + 1, :alt => alt + 1)
      
    @point_NE = Coordinate.new(:hour => h, :minute => m, :second => s + dt,
      :latitude => @lat + @delta,
      :longitude => @long + @delta, :validity => 'A', :palt => alt + 1, :alt => alt + 1)

    @point_SW = Coordinate.new(:hour => h, :minute => m, :second => s + dt,
      :latitude => @lat - @delta,
      :longitude => @long - @delta, :validity => 'A', :palt => alt + 1, :alt => alt + 1)

    @point_SE = Coordinate.new(:hour => h, :minute => m, :second => s + dt,
      :latitude => @lat - @delta,
      :longitude => @long + @delta, :validity => 'A', :palt => alt + 1, :alt => alt + 1)

      @point_NW = Coordinate.new(:hour => h, :minute => m, :second => s + dt,
      :latitude => @lat + @delta,
      :longitude => @long - @delta, :validity => 'A', :palt => alt + 1, :alt => alt + 1)
  end

  def test_compare
    compare_coord(@point, @point_N, "->N", :trk => 0.0)
    compare_coord(@point, @point_NE, "->NE")
    compare_coord(@point, @point_E, "->E", :trk => 90.0)
    compare_coord(@point, @point_SE, "->SE")
    compare_coord(@point, @point_S, "->S", :trk => 180.0)
    compare_coord(@point, @point_SW, "->SW")
    compare_coord(@point, @point_W, "->W", :trk => 270.0)
    compare_coord(@point, @point_NW, "->NW")
  end
  
  def test_basic
    @igc.load("485_UP.igc")
    assert(@igc, "Reader created")
    
    # @igc.display
    @igc.process()
    
  end
  
  def compare_coord (departure, arrival, comment, expected = {})
    puts "compare #{comment}"
    delta = arrival - departure
    puts "delta = #{delta.inspect}"
    puts "distance=#{delta.distance}"
    if (expected.key?(:trk))
      # assert_equal(expected[:trk], delta.trk, "trk #{comment}")
    end
    puts "trk=#{delta.trk}"
    puts "vs=#{delta.vs}"
    puts "kmh=#{delta.kmh}"
    puts "vz=#{delta.vz}"
    puts ""
  end
  

    
 
end