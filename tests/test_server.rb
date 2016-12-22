#!/usr/bin/env ruby

gem "minitest"

require 'minitest/autorun'
require 'socket'

# Simple test of a TCP/IP server
#
# The test assume that an HTTP server runs on localhost
#
# Connect
# send the request
#   GET / HTTP/1.1
#   Host: localhost
#   \n
# check that the server has replied somthing
class TestServer < MiniTest::Test
  
  def initialize(args)
    super(args)
    puts "\n# Suite " + self.class.name + "\n"
  end
  
  
  def setup
    @s = TCPSocket.new 'localhost', 80
    assert(@s, 'connected to localhost')
  end

  def test_basic
	 assert(1 == 1, "1 == 1 is true")

	 @s.puts("GET / HTTP/1.1")
   @s.puts("Host: localhost")
   @s.puts("")
   
   reply = ""
   while line = @s.gets # Read lines from socket
     reply += line
   end
   # puts reply
    
   assert(reply.length > 15, "reply is at least 15 characters")
   assert(reply =~ /HTTP/, "HTTP found in reply")
   assert(reply =~ /Server:/, "Server: found in reply")
   assert(reply =~ /Content-Type: text\/html/, "Content-Type found in reply")
   
  end
  
  def teardown
    @s.close
  end
     
end