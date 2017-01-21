#!/usr/bin/env ruby
# Empty Ruby unit test
#
# This script is a unit Ruby unit test template
#
# Author::    Frédéric  (mailto:fpeignot@x.y)

gem "minitest"
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
