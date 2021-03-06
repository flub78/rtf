#!/usr/bin/env ruby
require File.dirname(__FILE__) + '/my_test.rb'
require File.dirname(__FILE__) + '/init_test_set.rb'
require "myset"

Minitest.after_run {
  puts "\n#After run and results are displayed"
}

# Trig module unit test
class TestSet < MyMiniTest
    
  def setup
    @set1 = Myset.new(['a', 'b', 'c'])
    @empty = Myset.new([])
    @duplicated = Myset.new(['a', 'b', 'c', 'b', 'b', 'a'])
    comment("Setup")
  end
  
  def teardown
    comment("Teardown")
  end

  def test_basic
    
    description(
      'basic set operations',
      'sets are predefined')

    assert(@set1, "Set created")
    assert_equal('["a", "b", "c"]', @set1.to_s, "image of the first set")

    assert(@set1.include?('a'))
    assert(!@set1.include?('z'))
      
    assert_equal(3, @set1.size, "Size of the set")
    
    @set1.add('b')
    assert_equal(3, @set1.size, "Size does not change on insertion of an existing element")

    @set1.add('d')
    assert_equal(4, @set1.size, "Size increases on insertion of a non existing element")
    
    @set1.delete('b')
    assert(!@set1.include?('b'), "Element no more in the set after been deleted")
    assert_equal(3, @set1.size, "Size decremented by delete")

  end
    
  def test_empty_set
    description()
    assert(@empty, "Empty set created")
    assert_equal('[]', @empty.to_s, "image of the empty set")

    assert(!@empty.include?('z'))
    assert_equal(0, @empty.size, "Size of the empty set")
  end

  def test_duplicated
    description('check sets created with duplicated elements')

    assert(@duplicated, "Duplicated set created")
    assert_equal('["a", "b", "c"]', @duplicated.to_s, "image of the set with duplicated elements")
    assert_equal(3, @duplicated.size, "Size of the duplicated set")
  end
 
end