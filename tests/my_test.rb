# encoding: utf-8
# GVV unit test
# Test de la home page
#
gem "minitest"
require 'minitest/autorun'
require "minitest/ci"

Minitest::Ci.clean = false

class MyMiniTest < MiniTest::Test
  
  def comment(str)
    puts "\n# " + self.class.name + ':' + str + "\n"
  end
  
end
