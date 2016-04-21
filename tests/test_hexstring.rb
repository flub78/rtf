#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/my_test.rb'

require 'HexString.rb'

# Trig module unit test
class TestHexString < MyMiniTest
  
  def test_basic
    description('basic conversions between string and binary')
	str = "0123456789ABCDEF"
	bin = str.to_byte_string()
	
	decoded = bin.to_hex_string(false)

	assert_equal(8, bin.size, "bin size")
	assert_equal("0123456789abcdef", decoded, "decoded value")

	assert_equal("68 65 6c 6c 6f".to_byte_string, "hello", "hello from hexa")

	assert_equal("hello world".to_hex_string, "68 65 6c 6c 6f 20 77 6f 72 6c 64", "hello to hexa")

  end
     
end