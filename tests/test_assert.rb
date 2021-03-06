#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/my_test.rb'
require 'minitest/autorun'

# Simple example of sqlite access
class TestAssert < MyMiniTest
    
  def setup
  end

  def test_basic
   description("basic assertion checks")
	 assert(1 == 1, "1 == 1 is true")
  end
  
  def teardown
  end
     
end

# Use spec to have more descriptive use cases
# TestAssert is used in this example but it is more common to use the
# class to test.
describe TestAssert do
  before do
    # @meme = Meme.new
  end

  describe "when asked about cheeseburgers" do
    it "must respond positively" do
      "yes".must_equal "yes"
    end
  end

  describe "when asked about blending possibilities" do
    it "won't say no" do
      "yes".wont_match /^no/i
    end
  end
end