#!/usr/bin/env ruby
gem "minitest"

require 'minitest/autorun'
require "ranges"

##############################################################################
# Range module unit test
##############################################################################
class TestRanges < MiniTest::Test
  ##############################################################################
  # Create a few ranges to work with
  ##############################################################################
  def setup
    @delta = 1e-9
    @simple_range = Ranges.new([1...4])
    @empty = Ranges.new([])

    @range1 = Ranges.new([8..10, 1..4, 6..6])
    @range2 = Ranges.new([8..10, 1..4, 6...7])

    @left = Ranges.new([100...201, 300..400]);
    @right = Ranges.new([150..250, 350..450]);

    @alpha = Ranges.new(['a' .. 'h'])

    @incremental = @empty
  end

  ##############################################################################
  # Check nominal behavior
  ##############################################################################
  def test_nominal
    assert(@simple_range, "New range created")
    assert(@range2, "Range from range created")
    assert(@left, "@left")
    assert(@right, "@right")

    assert_equal("[1...4]", @simple_range.to_s, "@simple_range.to_s")
    assert_equal("[1..4, 6...7, 8..10]", @range2.to_s, "@range2.to_s")
  end

  ##############################################################################
  # Check errors detection
  ##############################################################################
  def test_errors
    assert_raises (RuntimeError) {
      @not_range = Ranges.new([150,250])
    }

    assert_raises (RuntimeError) {
      @mismatch = Ranges.new([150...250, 'a'..'c']);
    }
  end

  ##############################################################################
  # Check range incremental build
  ##############################################################################
  def test_incremental

    assert(@incremental, "Incremental range created")
    assert_equal(0, @incremental.section_number, "Size of an empty range")

    @incremental.add(1..4)
    assert_equal(1, @incremental.section_number, "Size after first add")

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

    @incremental.add(8..10)

    assert(@range1 == @incremental, "@range1 == @incremental")
    assert(@range2 != @simple_range, "@range2 != @simple_range")
    assert(@range2 == @incremental, "#{@range2.to_s} == #{@incremental.to_s}")
  end

  ##############################################################################
  ##############################################################################
  def test_iterator
    nb = 0
    @range2.each  do |elt|
      nb += 1
    end
    assert_equal(nb, @range2.size, "number of iteration")
  end

  ##############################################################################
  ##############################################################################
  def test_size
    assert_equal(8, @range2.size, "@range2.size")
    assert_equal(0, @empty.size, "empty.size")
    assert_equal(3, @range2.section_number, "@range2.section_number")
    assert_equal(0, @empty.size, "@empty.section_number")
  end

  ##############################################################################
  ##############################################################################
  def test_append
    @rg = Ranges.new([])
    assert_equal(0, @rg.size, "@rg.size")

    @rg << 8
    assert_equal(1, @rg.size, "@rg.size after append")
    assert(@rg.member?(8), "8 is in range " << @rg.to_s)

    @rg << 6
    assert_equal(2, @rg.size, "@rg.size after second append")
    assert(@rg.member?(6), "6 is in range " << @rg.to_s)

    @rg << 5
    assert(@rg.member?(5), "5 is in range " << @rg.to_s)

    @rg << 4
    assert(@rg.member?(4), "4 is in range " << @rg.to_s)

    @rg << 2
    @rg << 3
  end

  ##############################################################################
  ##############################################################################
  def test_union
    union = @left + @right
    assert_equal("[100..250, 300..450]", union.to_s, "#{@left} + #{@right} = #{union}")

    intersection = @left * @right
    assert_equal("[150..250, 350..450]", intersection.to_s, "#{@left} * #{@right} = #{intersection}")
  end
end