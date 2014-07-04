#!/usr/bin/env ruby
#
# === Name
#
# Thor script
#
# === Synopsis
# * analyses its arguments
# * Display an online help if --help or -h are recognised
# * Log some information
# * exit
#
# Author::    Frédéric  (mailto:fpeignot@x.y)

require "thor"

# a simple command interpretor
class MyCLI < Thor
  desc "hello NAME", "say hello to NAME"
  def hello(name)
    puts "Hello #{name}"
  end
end

MyCLI.start(ARGV)