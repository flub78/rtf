#!/usr/bin/env ruby

# Complete the Ruby library path
if (!ENV['RTF'])
  puts "Environment variable $RTF is not defined"
  exit
end
  
$: << "#{ENV['RTF']}/lib"
$: << "#{ENV['RTF']}/tests"

gem "minitest"

# List of tests to execute
require "test_assert.rb"
require "test_set.rb"
require "test_trig.rb"
require "test_ranges.rb"
require "test_hexstring.rb"
# require 'test_web_site.rb'
require 'test_dbi_mysql.rb'
require 'test_server.rb'
require 'test_dbbackup.rb'
