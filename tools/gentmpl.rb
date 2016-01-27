#!/usr/bin/env ruby
#
# === Name
#
# script.rb Empty Ruby script
#
# === Synopsis
# * analyses its arguments
# * Desiplay an onlye help if --help or -h are recognised
# * Log some information
# * exit
#
# Author::    Frédéric  (mailto:fpeignot@x.y)

require 'logger'
require 'getoptlong'
require 'fileutils'
require 'mustache'

$verbose = false;
$log = Logger.new File.new(File.basename($0, ".rb") << ".log", 'a+')

# specify the options we accept and initialize
# the option parser
opts = GetoptLong.new(
[ "--verbose", "-v",            GetoptLong::NO_ARGUMENT ],
[ "--help",    "-h",            GetoptLong::NO_ARGUMENT ]
)

# Display on line help
def usage
  puts "Template generator.
  
  This script scans a directory tree for template files and generate
  the outputs in another directory tree. 
  
  Template file must be compatible with the mustache format.
  http://mustache.github.io/

  usage: ruby  #{$0} [options]* source_dir result_dir

       Options:
         -h,--help            brief help message
         -v,--verbose         switch on verbose mode

  Exemple:

      ruby #{$0} --help
      ruby #{$0} source_dir result_dir

  Template rules:

  
" 
end

# Process a file
def process_file (template, results)
  puts "processing file(#{template}, #{results})"
  # FileUtils.cp(templates, results)
  
  file = File.open(template, "r")
  contents = file.read
  
  h = Hash[:planet => "World!",
    :gentmpl_cmd => "#{$PROGRAM_NAME} #{$*}",
    :gentmpl_date => Time.new.inspect,
    :gentmpl_template => "#{template}"]
  
  processed = Mustache.render(contents, h)    
  File.open(results, 'w') { |file| file.write(processed) }
  
end

# Process a file
def process (templates, results)
  $log.info "processing(templates: #{templates}, results: #{results})"
  
  if (!File.directory?(results))
    # create the directory
    FileUtils.mkdir_p(results)
  end

  if (File.directory?(templates))
    # parse the directory
    Dir.foreach(templates) do |item|
      next if item == '.' or item == '..'
      # do work on real items
            
      if (File.directory?(templates + '/' + item))
        process(templates + '/' + item, results + '/' + item)
      end

      if (File.file?(templates + '/' + item))
        process_file(templates + '/' + item, results + '/' + item)
      end
      
    end
  end
  
    
end


# process the parsed options
opts.each do |opt, arg|
  puts "Option: #{opt}, arg #{arg.inspect}"
  if (opt == "--help")
    usage
    exit

  elsif (opt == "--verbose")
    $verbose = true
  end

end

# puts "Remaining args: #{ARGV.join(', ')}"
if ARGV.length != 2
  puts "Missing arguments (try --help)"
  exit 0
end

# Main processing
# ---------------
if ($verbose)
  $log.info "Script start"
  puts "HOME=#{ENV['HOME']}"
  puts "Ruby library path=#{$:}"
end

templates_dir = ARGV[0]
resuts_dir = ARGV[1]

if (!File.directory?(templates_dir) && !File.file?(templates_dir))
  puts "First argument must be a file or a directory (try --help)"
  exit 0
end 

process(ARGV[0], ARGV[1])

if ($verbose)
  $log.info "bye."
end