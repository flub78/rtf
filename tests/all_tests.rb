#!/usr/bin/env ruby

# Complete the Ruby library path
if (!ENV['RTF'])
  puts "Environment variable $RTF is not defined"
  exit
end
  
$: << "#{ENV['RTF']}/lib"
$: << "#{ENV['RTF']}/tests"

gem "minitest"

require "test_set.rb"
require "test_trig.rb"
require "test_range.rb"
