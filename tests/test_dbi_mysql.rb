#!/usr/bin/env ruby

gem "minitest"

require 'minitest/autorun'
require 'dbi'

# Simple example of sqlite access
# sudo gem install dbi
# sudo gem install dbd-sqlite3
# sudo gem install dbd-mysql
class TestDBIMysql < MiniTest::Test
  
  def setup
    @dbh = DBI.connect('DBI:Mysql:test', 'testuser', 'testpwd')
    # @dbh = DBI.connect('DBI:SQLite3:test', 'testuser', 'testpwd')

    # Create the table    
    sql = "CREATE TABLE IF NOT EXISTS `simple01` (
      `SongName` varchar(64) NOT NULL,
      `SongLength_s` int(11) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Example'";

    sql = "CREATE TABLE IF NOT EXISTS `simple01` (
      `SongName` varchar(64) NOT NULL,
      `SongLength_s` int(11) NOT NULL
    ) ";
    
    @dbh.do(sql)
      
    row = @dbh.select_one("SELECT VERSION()")
    puts "Server version: " + row[0]

  end

  def teardown
    @dbh.disconnect
    assert_equal(@dbh.handle, nil, "Database connection closed")
  end
  
  def test_basic
    assert(true, "True")
    assert(@dbh, "Connected to database")
    
    # Insert some rows, use placeholders
    1.upto(13) do |i|
        sql = "insert into simple01 (SongName, SongLength_s) VALUES (?, ?)"
        @dbh.do(sql, "Song #{i}", "#{i*10}")
    end
      
    @dbh.select_all('select * from simple01;').each do | row |
      p row
    end
              
    
    # Don't prepare, just do it!
    @dbh.do('delete from simple01 where SongLength_s > 10')

  end
     
end