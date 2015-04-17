# This is just a Ruby module to handle the project todo list under Eclipse
#
# For some reasons the Eclipse task list parser does not parse .rdoc files.
#
# === Project todo list
#
# TODO TCP/IP server and client with OpenSSL
# TODO Experiment on SOAP client and servers
# TODO Experiment on cryptography
module Todo
  Priorities = [:urgent, :normal, :low]
  
  # Return a list of priorities
  def priorities()
    return Priorities
  end
  
end

