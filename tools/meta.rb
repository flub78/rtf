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
      ruby #{$0} generate source_dir result_dir

    Clone directory structure (copy directories and create link on files)
      ruby #{$0} clone source_dir cloned_dir
  
      ruby #{$0} tables
      ruby #{$0} views
      ruby #{$0} --table=users_groups fields
      ruby #{$0} --table=users_groups --field=user_id info
      ruby #{$0} gen templates results
  
  Template rules:

    {{cmd}} :      command
    {{date}} :     processing date
    {{template}} : source file  
" 
end

def rules
  str = "cou"
  return str + str
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
      puts "\tfile #{result} is not writable"
    end
  else
    file = File.open(template, "r")
    contents = file.read
  
    tables = [
      {:name => "table1", :fields => ["field1", "field2"]},
      {:name => "table2", :fields => "aaaa"},
      {:name => "table3", :fields => "bbbb"}
    ]
    
    h = Hash[:planet => "World!",
      :cmd => "#{$PROGRAM_NAME} #{$*}",
      :date => Time.new.inspect,
      :template => "#{template}",
      :tables => tables,
      :rules => rules,
      "table2".to_sym => {:field1 => "table2222"},
      :table1 => {:fields => [
        {name: "first_name", input: "<input></input>"}, 
        {name: "name", input: "<select></select>"}, 
        {name: "birthdate"}]
      }       
      ]
  
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
# Read the metadata and generate a hash
#
#   tables = {
#     :table1 =>   
#       {:name => "table1",
#        :fields => {
#           :fiedl1 => {:name => 'field1', :input => 'input1', :display => 'display1'},
#           :field2 => {}}},
# {:name => "table2", :fields => "aaaa"},
# {:name => "table3", :fields => "bbbb"}
# }
# --------------------------------------------------------------------
def gen_meta
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
# List views
# --------------------------------------------------------------------
def views_list(database)
  puts "Views\n"

  tables = $metadata.views(database)
  tables.each do |table|
    puts "\t#{table}\n"
  end
end

# --------------------------------------------------------------------
# Display field information
# --------------------------------------------------------------------
def field_info(database, table, field, mode='list')
  puts "\t\t#{field}\n"
  if (mode == 'info')
    info = $metadata.field_info(database, table, field)
    info.each do |key, value|
      puts "\t\t\t#{key} => #{value}"
    end
  elsif (mode == 'display')
    return $metadata.field_display(database, table, field)
  elsif (mode == 'input')
    return $metadata.field_input(database, table, field)
  elsif (mode == 'rules')
    return $metadata.field_rules(database, table, field)
  end  
end

# --------------------------------------------------------------------
# Display information for several fields
# --------------------------------------------------------------------
def display_fields(database, table, field, mode='list')
  puts "\t#{table}\n"
  fields = $metadata.fields(database, table)
  if (field == nil)
    fields.each do |field|
      field_info(database, table, field, mode)
    end
  else
    field_info(database, table, field, mode)
  end
end

# --------------------------------------------------------------------
# List fields
# --------------------------------------------------------------------
def fields_list(database, table, field, mode='list')
  puts "Fields\n"

  if (table == nil)
    tables = $metadata.tables(database)
    tables.each do |table|
      display_fields(database, table, field, mode)
    end
  else
    display_fields(database, table, field, mode)    
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

actions = ['gen', 'generate', 'tables', 'views', 'fields', 'clone', 'info', 'input', 'display', 'rules']
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
elsif (action == 'views')
  views_list($database)
elsif (action == 'fields')
  fields_list($database, $table, $field)
elsif (action == 'info')
  fields_list($database, $table, $field, 'info')
elsif (action == 'input')
  fields_list($database, $table, $field, 'input')
elsif (action == 'display')
  fields_list($database, $table, $field, 'display')
elsif (action == 'rules')
  fields_list($database, $table, $field, 'rules')
end 


if ($verbose)
  $log.info "bye."
end