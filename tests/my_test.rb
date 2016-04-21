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
    puts "# " + str
  end


  def description(verify="", pwhen="", given="")
    comment(self.class.name + ':' + caller[0].split(' ')[1].slice(1..-2))

    if (!verify.empty?)
      comment('   Verify ' + verify)
    end
    if (!pwhen.empty?)
      comment('   When ' + pwhen)
    end
    if (!given.empty?)
      comment('   Given ' + given)
    end
  end
  
end
