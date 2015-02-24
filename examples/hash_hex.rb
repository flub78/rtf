#!/usr/bin/env ruby
#
# === Name
#
# tk example
#
# === Synopsis
# TK hello world
#
# Author::    Frédéric  (mailto:fpeignot@x.y)

require 'HexString.rb'
require 'digest/sha1'

hash_sum = 2007

ipad_hex =  "59 5F 43 05 04 46 5A 5A  36 36 36 36 36 36 36 36" 
ipad_hex += "36 36 36 36 36 36 36 36  36 36 36 36 36 36 36 36" 
ipad_hex += "36 36 36 36 36 36 36 36  36 36 36 36 36 36 36 36"
ipad_hex += "36 36 36 36 36 36 36 36  36 36 36 36 36 36 36 36"
ipad = ipad_hex.to_byte_string()

opad_hex =  "33 35 29 6F 6E 2C 30 30  5C 5C 5C 5C 5C 5C 5C 5C"
opad_hex += "5C 5C 5C 5C 5C 5C 5C 5C  5C 5C 5C 5C 5C 5C 5C 5C"
opad_hex += "5C 5C 5C 5C 5C 5C 5C 5C  5C 5C 5C 5C 5C 5C 5C 5C"
opad_hex += "5C 5C 5C 5C 5C 5C 5C 5C  5C 5C 5C 5C 5C 5C 5C 5C"
opad = opad_hex.to_byte_string()

value = []
for i in 0..7
  value << (hash_sum % 256)
  hash_sum = hash_sum / 256 
end

bin_value = value.pack("C*")

digest = Digest::SHA1.digest(ipad + bin_value)
digest2 = Digest::SHA1.digest(opad + digest)

puts "digest=\"#{digest2.to_hex_string}\" "



