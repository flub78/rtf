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

puts ("Hello world");

x = 1;
while (x < 50)
  if (x > 25) 
    puts ("Big!");
  else 
    puts("Small..");
  end
  x += 1;
end