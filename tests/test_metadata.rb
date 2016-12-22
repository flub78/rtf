#!/usr/bin/env ruby
# Basic class unit test
# Author::    Frédéric  (mailto:fpeignot@x.y)

require File.dirname(__FILE__) + '/my_test.rb'

require "metadata"

class UnitTest < MyMiniTest
  
  def setup
    @instance = Metadata.new(
      :dbdriver => 'DBI:Mysql:test', :user => 'testuser', :password => 'testpwd')   
    @instance.connect
  end

  def teardown
    @instance.close
  end
  
  def test_default
    description('basic operations on database metadata access')
    assert(@instance, "@instance created")
    
    tables = @instance.tables('ci3')
    # p tables.inspect
    assert(tables.count == 9, "9 tables in the test database")
    
    fields = @instance.fields('ci3', 'meta_test1')
    # p fields.inspect
    assert(fields.count == 11, "11 fields in meta_test1")

    views = @instance.views('ci3')
    # p views.inspect
    assert(views.count == 2, "2 views in the test database")
    
    fields.each do |field|
      info = @instance.field_info('ci3', 'meta_test1', field)
      # p info.inspect
    end

    assert(@instance.is_view?('ci3', 'users_view'), "is_view? true")
    assert(! @instance.is_view?('ci3', 'users'), "is_view? false")
    assert(! @instance.is_view?('ci3', 'unknown_table'), "is_view?(unknown) false")

    reference = @instance.reference('ci3', 'users_view', 'id')
    assert(reference == ["users", "id"], "reference('users_view', 'id')")
    reference = @instance.reference('ci3', 'users', 'id')
    assert(reference == ["users", "id"], "reference('users', 'id')")
 
    reference = @instance.reference('ci3', 'users', 'unknown_field')
    assert(reference == ["users", "unknown_field"], "reference('users', 'unknown_field')")
    reference = @instance.reference('ci3', 'unknown_table', 'unknown_field')
    assert(reference == ["unknown_table", "unknown_field"], "reference('unknown_table', 'unknown_field')")

    assert(!@instance.is_foreign_key?('ci3', 'users', 'id'), "is_foreign_key?('users', 'id')")   
    assert(@instance.is_foreign_key?('ci3', 'meta_test1', 'oaci'), "is_foreign_key?('meta_test1', 'oaci')")   

    referenced = @instance.foreign_key('ci3', 'meta_test1', 'oaci')
    expected = {:database=>"ci3", :table=>"meta_test2", :field=>"oaci"}
    assert(expected == referenced, "foreign_key('meta_test1', 'oaci')")

    referenced = @instance.foreign_key('ci3', 'users', 'id')
    expected = {:database=>nil, :table=>nil, :field=>nil}
    assert(expected == referenced, "foreign_key('users', 'id')")
    
    referenced = @instance.foreign_key('ci3', 'unknown_table', 'id')
    expected = {:database=>nil, :table=>nil, :field=>nil}
    assert(expected == referenced, "foreign_key('unknown_table', 'id')")
  end

end
