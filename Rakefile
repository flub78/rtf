#
# RTF rake file
#
require 'rdoc/task'

desc "Start RTF unit tests"
task test: [] do
  
  if (!ENV['RTF'])
    puts "Environment variable $RTF is not defined"
    exit
  else
    puts "RTF=#{ENV['RTF']}"
  end
    
  require "./tests/all_tests.rb"
  
end

RDoc::Task.new  do |rdoc|
  rdoc.main = "README.doc"
  rdoc.rdoc_files.include("README.rdoc")
  rdoc.rdoc_files.include("lib/*.rb")
  rdoc.rdoc_files.include("templates/*.rb")
  rdoc.rdoc_files.include("tools/*.rb")
  rdoc.options << "--all"
end


#task task_name: [:prerequisite_task, :another_task_we_depend_on] do
#  # All your magic here
#  # Any valid Ruby code is allowed
#end