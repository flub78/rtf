#!/usr/bin/env ruby
#
# === Name
#
# gentmpl.rb  
#
# === Synopsis
# See help below.
#
# ./gentmpl.rb          no actions
# ./gentmpl.rb --help   display help
# ./gentmpl.rb [action] [params]*
# ./gentmpl.rb gen|generate template_dir result_dir
# ./gentmpl.rb --database db --table tbl tables             list existing tables
# ./gentmpl.rb --database db --table tbl fields              list existing fields
# ./gentmpl.rb --database db --table tbl --field fld info     print info on field
# ./gentmpl.rb --database db --table tbl --field fld input  
# ./gentmpl.rb --database db --table tbl --field fld rule
# ./gentmpl.rb --database db --table tbl --field fld display
#
# Author::    Frédéric  (mailto:fpeignot@x.y)

require 'logger'
require 'getoptlong'
require 'fileutils'
require 'mustache'
require "metadata"

$verbose = false;
$log = Logger.new File.new(File.basename($0, ".rb") << ".log", 'a+')

$database = 'ci3' # database name
$user = 'testuser'
$password = 'testpwd'
$metadata = nil
$table = nil
$field = nil

# specify the options we accept and initialize
# the option parser
opts = GetoptLong.new(
[ "--verbose", "-v",            GetoptLong::NO_ARGUMENT ],
[ "--help",    "-h",            GetoptLong::NO_ARGUMENT ],
[ '--database', '-d', GetoptLong::REQUIRED_ARGUMENT ],
[ '--table', '-t', GetoptLong::REQUIRED_ARGUMENT ],
[ '--field', '-f', GetoptLong::REQUIRED_ARGUMENT ]
)

# Display on line help
def usage
  puts "Metadata tool
  
  * Display of database metadata
  * mustache template generation based on metadata
  * directory structure clone
  
  Template file must be compatible with the mustache format.
  http://mustache.github.io/

  usage: ruby  #{$0} [options]* action [parameters]

       Options:
         -h,--help            brief help message
         -v,--verbose         switch on verbose mode

  Exemple:

    Display help:
      ruby #{$0} --help
  
    Generate mustache template
      ruby #{$0} gen|generate source_dir result_dir

    Clone directory structure (copy directories and create link on files)
    ruby #{$0} clone source_dir result_dir

  Template rules:

  
" 
end

# --------------------------------------------------------------------
# Process a file
# --------------------------------------------------------------------
def process_file (template, result, mode="template")
  puts "processing file(#{template}, #{result}, #{mode})"
  
  if (mode == 'clone') 
    # FileUtils.cp(templates, result)
    if File.stat(result).writable?
      FileUtils.link(template, result, :force => true)
    else
      puts "file #{result} is not writable"
    end
  else
    file = File.open(template, "r")
    contents = file.read
  
    h = Hash[:planet => "World!",
      :gentmpl_cmd => "#{$PROGRAM_NAME} #{$*}",
      :gentmpl_date => Time.new.inspect,
      :gentmpl_template => "#{template}"]
  
    processed = Mustache.render(contents, h)    
    File.open(result, 'w') { |file| file.write(processed) }
  end
end

# --------------------------------------------------------------------
# Generate template in a directory tree
# --------------------------------------------------------------------
def process (templates, results, mode="template")
  $log.info "processing(templates: #{templates}, results: #{results})"
  
  if (!File.directory?(templates) && !File.file?(templates))
    puts "First argument must be a file or a directory (try --help)"
    exit 0
  end
    
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
        process(templates + '/' + item, results + '/' + item, mode)
      end

      if (File.file?(templates + '/' + item))
        process_file(templates + '/' + item, results + '/' + item, mode)
      end
      
    end
  end  
end

# --------------------------------------------------------------------
# List schema tables
# --------------------------------------------------------------------
def tables_list(database)
  puts "Tables\n"

  tables = $metadata.tables(database)
  tables.each do |table|
    puts "\t#{table}\n"
  end
end

# --------------------------------------------------------------------
# List schema tables
# --------------------------------------------------------------------
def views_list(database)
  puts "Views\n"

  tables = $metadata.views(database)
  tables.each do |table|
    puts "\t#{table}\n"
  end
end

###############
# Main script #
###############

# process the parsed options
opts.each do |opt, arg|
  # puts "Option: #{opt}, arg #{arg.inspect}"
  if (opt == "--help")
    usage
    exit
  elsif (opt == "--database")
    $database = arg
  elsif (opt == "--table")
      $table = arg
  elsif (opt == "--field")
      $field = arg
  elsif (opt == "--verbose")
    $verbose = true
  end

end

# puts "Remaining args: #{ARGV.join(', ')}"
if ARGV.length < 1
  puts "Missing arguments (try --help) " + ARGV.length.to_s
  exit 0
end

$metadata = Metadata.new(:dbdriver => 'DBI:Mysql:test', :user => $user, :password => $password)   
$metadata.connect()

if ($verbose)
  $log.info "Script start"
  puts "HOME=#{ENV['HOME']}"
  puts "Ruby library path=#{$:}"
end

action = ARGV[0]
templates_dir = ARGV[1]
results_dir = ARGV[2]

actions = ['gen', 'generate', 'tables', 'views', 'fields', 'clone']
if (! actions.include? action)
  puts "Unknow action #{action} (try --help)"
  exit 0    
end

if (action == 'gen' || action == 'generate')  
  process(templates_dir, results_dir)  
elsif (action == 'clone')
  process(templates_dir, results_dir, 'clone')  
elsif (action == 'tables')
  tables_list($database)
elsif (action == 'tables')
  views_list($database)
elsif (action == 'fields')
    # field_list($database, $table)
end 


if ($verbose)
  $log.info "bye."
end