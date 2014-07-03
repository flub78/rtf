#!/usr/bin/env ruby
#
# grep command emulation
#
# Author::    Frédéric  (mailto:fpeignot@x.y)

require 'logger'
require 'find'
require 'getoptlong'

verbose = false;
log = Logger.new File.new(File.basename($0, ".rb") << ".log", 'a+')
pattern = ""

# cat command (example of file procesing)

# specify the options we accept and initialize
# the option parser
opts = GetoptLong.new(
[ "--pattern",    "-p",            GetoptLong::REQUIRED_ARGUMENT ],
[ "--verbose", "-v",            GetoptLong::NO_ARGUMENT ],
[ "--help",    "-h",            GetoptLong::NO_ARGUMENT ]
)

# Display on line help
def usage
  puts "search files from a pattern occurences

  usage: ruby #{$0} [options]* [filename]*

       Options:
         -h,--help            brief help message
         -v,--verbose         switch on verbose mode
         -p, --pattern        pattern to look for 

  Exemple:

      ruby #{$0} --help
      ruby #{$0} #{$0}
"
end

# Display a file
def grep (filename, pattern)
  file = File.open(filename, "rb")
  counter = 1
  while (line = file.gets)
      puts "#{filename}:#{counter}: #{line}" if (line.match( /#{pattern}/))
      counter = counter + 1
  end
  file.close
end

# Process a file
def process (filename, pattern)
  if File.directory?(filename)
    puts "dir #{filename}"
    Find.find(filename) do |f|
      process(f, pattern) if (f != "." && f != "..")
    end
  else
    grep(filename, pattern)
  end
end

# process the parsed options
opts.each do |opt, arg|
  if (opt == "--help")
    usage
    exit

  elsif (opt == "--pattern")
      pattern = arg

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
  process(arg, pattern)
end

if (verbose)
  log.info "bye."
end