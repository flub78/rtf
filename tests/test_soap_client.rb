#!/usr/bin/env ruby

gem "minitest"

require 'minitest/autorun'
require 'savon.rb'

# Simple example of sqlite access
class TestSoapClient < MiniTest::Test
  
  def setup
    @client = Savon.client(wsdl: "http://example.com?wsdl")
    p @client.operations()
  end

  def test_basic
	 assert(1 == 1, "1 == 1 is true")
  end
  
  def teardown
  end
     
end