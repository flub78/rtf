#!/usr/bin/env ruby
# Empty Ruby script
#
# This script:
# * analyses its arguments
# * Desiplay an onlye help if --help or -h are recognised
# * Log some information
# * exit
#
# Author::    Frédéric  (mailto:fpeignot@x.y)

require 'logger'

# Display on line help
def usage 
  puts "Script template. 
  
  usage: ruby ./script.rb [options]
  
       Options:
         -h,--help            brief help message
         -v,--verbose         switch on verbose mode
         -c,--count           example of integer option
         -p,--pattern         pattern to search
         -a,--all             process also hidden files
         -m,--match           only process matching files
          
  Exemple:
  
      ruby ./script.rb --help
      ruby ./script.rb --pattern 'def' script.rb
      
  Features:
  
      This script has been designed as an example that you can modify easily
      to adapt it to your needs. The treatment given as example counts a pattern
      in several files given as parameters.
  
      - It is self documented using NaturalDocs (multi-languages, HTML, natural syntax)
      - The command line is parsed using Getopt::Long;
      - It supports a --help parameter
      - It logs information using log4perl        
"
end

# Prints hello world
def hello
  puts "Hello World"
end
  
verbose = false;
log = Logger.new File.new('script.log', 'a+')
  
# Analyse CLI arguments
ARGV.each do|a|
  if (a == "--help" || a == "-h") 
    usage
    exit
    
  elsif (a == "--verbose" || a == "-v")
    verbose = true 
  end
  
end

# Main processing
# ---------------
    
if (verbose)
  log.info "Script start" 
end
  
hello
    
if (verbose)
  log.info "bye." 
end