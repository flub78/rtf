#!/usr/bin/env ruby
require 'minitest/autorun'
require "ranges"

# Trig module unit test
class TestRanges < MiniTest::Test
  def setup
    @delta = 1e-9
    @simple_range = Ranges.new([1...4])

    @range2 = Ranges.new([2..6, 8..10])

    @left = Ranges.new([100...201, 300..400]);
    @right = Ranges.new([150..250, 350..450]);

    @alpha = Ranges.new(['a' .. 'h'])

    @incremental = Ranges.new([])
   
  end

  def test_nominal    
    assert(@simple_range, "New range created")
    assert(@range2, "Range from range created")
    assert(@left, "@left")
    assert(@right, "@right")
    
    puts "@simple_range = #{@simple_range.to_s}"
    puts "@range2 = #{@range2}"
  end
    
  def test_errors
    assert_raises (RuntimeError) {
      @not_range = Ranges.new([150,250])
    }
    
    assert_raises (RuntimeError) {
      @mismatch = Ranges.new([150...250, 'a'..'c']);
    }
    
  end
  
  def test_incremental
    
    assert(@incremental, "Incremental range created")
    assert_equal(0, @incremental.size, "Size of an empty range")
    
    @incremental.add(1..4)
    assert_equal(1, @incremental.size, "Size after first add")

    assert(!@incremental.member?(0), "0 is not in range " << @incremental.to_s)
    assert(@incremental.member?(1), "1 is in range " << @incremental.to_s)
    assert(!@incremental.member?(5), "5 is not in range " << @incremental.to_s)
    
    (1 .. 4).each do |val|
      assert(@incremental.member?(val), "#{val} is in range " << @incremental.to_s)
    end
    
    @incremental.add(6..6)
    assert(!@incremental.member?(5), "5 is still not in range " << @incremental.to_s)
    assert(!@incremental.member?(7), "7 is not in range " << @incremental.to_s)
    assert(@incremental.member?(6), "6 is in range " << @incremental.to_s)

    

  end
    
end