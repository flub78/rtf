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

class UnitTest < MiniTest::Test
  def setup
    @name = "joe"
  end

  def test_that_kitty_can_eat
    assert_equal "joe", @name
  end

  def test_that_it_will_not_blend
    refute_match /^no/i, @name
  end
end
