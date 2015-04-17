#!/usr/bin/env ruby
#
# === Name
#
# tk example
#
# === Synopsis
# TK hello world
#
# Author::    Frédéric  (mailto:fpeignot@x.y)

require 'tk'

root = TkRoot.new { title "Hello, World!" }
TkLabel.new(root) do
   text 'Hello, World!'
   pack { padx 15 ; pady 15; side 'left' }
end
Tk.mainloop