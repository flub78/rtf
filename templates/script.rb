#!/usr/bin/env ruby
#
# === Name
#
# script.rb Empty Ruby script
#
# === Synopsis
# * analyses its arguments
# * Display online help if --help or -h are recognized
# * Log some information
# * exit
#
# Author::    Frédéric  (mailto:fpeignot@x.y)

require 'logger'
require 'getoptlong'

# specify the options we accept and initialize
# the option parser
opts = GetoptLong.new(
[ "--size",    "-s",            GetoptLong::REQUIRED_ARGUMENT ],
[ "--verbose", "-v",            GetoptLong::NO_ARGUMENT ],
[ "--help",    "-h",            GetoptLong::NO_ARGUMENT ],
[ "--check",   "--valid", "-c", GetoptLong::NO_ARGUMENT ]
)

# Display on line help
def usage
  puts "Script template.

  usage: ruby  #{$0} [options]* [filename]*

       Options:
         -h,--help            brief help message
         -v,--verbose         switch on verbose mode
         -s,--size            example of integer option
         -p,--pattern         pattern to search
         -a,--all             process also hidden files
         -m,--match           only process matching files

  Exemple:

      ruby #{$0} --help
      ruby #{$0} --pattern 'def' script.rb

  Features:

      This script has been designed as an example that you can modify easily
      to adapt it to your needs. The treatment given as example counts a pattern
      in several files given as parameters.

      - It is self documented using rdoc
      - The command line is parsed using Getopt::Long;
      - It supports a --help parameter
      - It logs information using a Ruby logger
"
end

# Process a file
def process (filename)
  puts "argument: #{filename}"
end

verbose = false;
log = Logger.new File.new(File.basename($0, ".rb") << ".log", 'a+')

# process the parsed options
opts.each do |opt, arg|
  puts "Option: #{opt}, arg #{arg.inspect}"
  if (opt == "--help")
    usage
    exit

  elsif (opt == "--verbose")
    verbose = true
  end

end

# puts "Remaining args: #{ARGV.join(', ')}"

# Main processing
# ---------------
if (verbose)
  log.info "Script start"
  puts "HOME=#{ENV['HOME']}"
  puts "Ruby library path=#{$:}"
end

ARGV.each do |arg|
  process (arg)
end

if (verbose)
  log.info "bye."
end