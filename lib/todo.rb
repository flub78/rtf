# This is just a Ruby module to handle the project todo list under Eclipse
#
# For some reasons the Eclipse task list parser does not parse .rdoc files.
#
# === Project todo list
#
# TODO make an example of library class with unit test
#
# TODO connect with jenkins
#
# TODO TCP/IP server and client
#
# TODO TCP/IP server and client with OpenSSL
#
module Todo
  Priorities = [:urgent, :normal, :low]
  
  # Return a list of priorities
  def priorities()
    return Priorities
  end
  
end

