#!/usr/bin/env ruby

gem "minitest"

require 'minitest/autorun'
require 'dbi'

# Simple example of sqlite access
# sudo gem install dbi
# sudo gem install dbd-sqlite3
# sudo gem install dbd-mysql
class TestDBIMysql < MiniTest::Test
  
  # --------------------------------------------------------------------------------
  # --------------------------------------------------------------------------------
  def setup
    
    @db_type = "mysql"
    # @db_type = "sqlite"
    
    if (@db_type == "mysql")
      @dbh = DBI.connect('DBI:Mysql:test', 'testuser', 'testpwd')
    else
      @dbh = DBI.connect('DBI:SQLite3:test', 'testuser', 'testpwd')
    end
      
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
    
    if (@db_type == "mysql")  
      row = @dbh.select_one("SELECT VERSION()") 
      puts "Server version: " + row[0]
    end
    
  end

  # --------------------------------------------------------------------------------
  # --------------------------------------------------------------------------------
  def teardown
    
    if (@db_type == "mysql")
      @dbh.disconnect
      assert_equal(@dbh.handle, nil, "Database connection closed")
    end
  end
  
  
  # --------------------------------------------------------------------------------
  # count the number of result returned by a query
  # --------------------------------------------------------------------------------
  def sql_count (dbh, query)
    sth = dbh.prepare(query)
    sth.execute
    count = sth.fetch_all.size
    sth.finish
    return count
  rescue DBI::DatabaseError => e
    puts "Database error code=#{e.err} #{e.errstr}"
  end
 
  # --------------------------------------------------------------------------------
  # return the result of a query in a hash
  # --------------------------------------------------------------------------------
  def sql_select_one_hash (dbh, query)
  end
  
  # --------------------------------------------------------------------------------
  # return the result of a query into a hash
  # --------------------------------------------------------------------------------
  def sql_select_all_hash (dbh, query)
    sth = dbh.prepare(query)
    sth.execute
    rows = sth.fetch_all
     
    names = sth.column_names

    result = []
    rows.each do |row|    
      i = 0
      line = {}
      names.each do |name|
        line[name] = row[i]
        i += 1
      end
      result << line
    end
    
    sth.finish
    return result
  rescue DBI::DatabaseError => e
    puts "Database error code=#{e.err} #{e.errstr}"
  end

# --------------------------------------------------------------------------------
  # Test basic database accesses  
  # --------------------------------------------------------------------------------
  def test_basic
    assert(@dbh, "Connected to database")
    
    # Insert some rows, use placeholders
    1.upto(13) do |i|
        sql = "insert into simple01 (SongName, SongLength_s) VALUES (?, ?)"
        @dbh.do(sql, "Song #{i}", "#{i*10}")
    end
    
    # read all  
    @dbh.select_all('select * from simple01;').each do | row |
      p row[0]
    end
    
    # read all
    sth = @dbh.prepare("select * from simple01;")
    sth.execute
    
    rows = sth.fetch_all do |row|
      puts "SongName = \"#{row[0]}\", SongLength_s = \"#{row[1]}\""  
    end
        
    sth.finish

    p self.sql_select_all_hash(@dbh, 'select * from simple01;')
     
    puts "count = #{sql_count(@dbh, 'select * from simple01;')}"
    puts "count = #{sql_count(@dbh, 'select * from simple02;')}"

    # p self.sql_select_one_hash(@dbh, 'select * from simple01 where SongName="Song 7";')
       
    # Don't prepare, just do it!
    @dbh.do('delete from simple01')

  end
     
end