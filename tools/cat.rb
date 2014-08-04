#!/usr/bin/env ruby
#
# cat command emulation
#
# Author::    Frédéric  (mailto:fpeignot@x.y)

require 'logger'
require 'find'
require 'getoptlong'

verbose = false;
log = Logger.new File.new(File.basename($0, ".rb") << ".log", 'a+')

# cat command (example of file procesing)

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
  puts "concatenate files and print on the standard output

  usage: ruby #{$0} [options]* [filename]*

       Options:
         -h,--help            brief help message
         -v,--verbose         switch on verbose mode

  Exemple:

      ruby #{$0} --help
      ruby #{$0} #{$0}
"
end

# Display a file
def display (filename)
  file = File.open(filename, "rb")
  puts file.read
  file.close
end

# process the parsed options
opts.each do |opt, arg|
  # puts "Option: #{opt}, arg #{arg.inspect}"
  if (opt == "--help")
    usage
    exit

  elsif (opt == "--verbose")
    verbose = true
  end

end

# Main processing
# ---------------
if (verbose)
  log.info "Script start"
  puts "HOME=#{ENV['HOME']}"
  puts "Ruby library path=#{$:}"
end

ARGV.each do |arg|
  display (arg)
end

if (verbose)
  log.info "bye."
end