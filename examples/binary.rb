#!/usr/bin/env ruby
#
# === Name
#
# Experiment on binary variables
#
# === Synopsis
# TK hello world
#
# Author::    Frédéric  (mailto:fpeignot@x.y)

require 'HexString.rb'
require 'digest/sha1'

puts ("Experiment on binary variables");

x = 0xFF
puts "x=#{x}"

puts ""
str = "0123456789ABCDEF"
bin = str.to_byte_string()

puts "str=#{str} str.size=#{str.size}"
puts "bin.size=#{bin.size}"

decoded = bin.to_hex_string(false)
puts "decoded=#{decoded} str.size=#{decoded.size}"

ipad_hex =            "59 5F 43 05 04 46 5A 5A  36 36 36 36 36 36 36 36" 
ipad_hex = ipad_hex + "36 36 36 36 36 36 36 36  36 36 36 36 36 36 36 36" 
ipad_hex = ipad_hex + "36 36 36 36 36 36 36 36  36 36 36 36 36 36 36 36"
ipad_hex = ipad_hex + "36 36 36 36 36 36 36 36  36 36 36 36 36 36 36 36"
ipad = ipad_hex.to_byte_string()

opad_hex = "33 35 29 6F 6E 2C 30 30 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C 5C"
opad = opad_hex.to_byte_string()

puts ""
puts "ipad=#{ipad.to_hex_string}"

puts "opad=#{opad.to_hex_string}"

hash_sum = 2007
value = []
for i in 0..7
  value << (hash_sum % 256)
  hash_sum = hash_sum / 256 
end

puts "value=#{value}"
bin_value = value.pack("C*")
puts "bin_value = #{bin_value.to_hex_string}"

digest = Digest::SHA1.digest(ipad + bin_value)
digest2 = Digest::SHA1.digest(opad + digest)

puts ""
puts "digest2=\"#{digest2.to_hex_string}\" "



