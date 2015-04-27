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
  # Before each test
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

    row = @dbh.select_one("SELECT COUNT(*) FROM simple01;")
    puts "Count: #{row[0]}" 

  end

  # --------------------------------------------------------------------------------
  # After each test
  # --------------------------------------------------------------------------------
  def teardown
    if (@db_type == "mysql")
      @dbh.disconnect
      assert_equal(@dbh.handle, nil, "Database connection closed")
    end
  end

  # --------------------------------------------------------------------------------
  # Numeric index of column names
  # --------------------------------------------------------------------------------
  def name_index(str_array)
    res = Hash.new
    cnt = 0
    str_array.each do |str|
      res[str] = cnt
      cnt += 1
    end
    return res
  end

  # --------------------------------------------------------------------------------
  # Test basic database accesses
  # --------------------------------------------------------------------------------
  def select_all(dbh, query)
    # read all
    puts "###############################################################"
    begin
      sth = dbh.execute(query)
      rows = sth.fetch_all
      count = rows.count
      name_index = name_index(sth.column_names)
      # p "name_intex=" + name_index.to_s
      0.upto(count-1) do |i|
        puts "#{i} SongName = \"#{rows[i][name_index['SongName']]}\", SongLength_s = \"#{rows[i][name_index['SongLength_s']]}\""
      end

      sth.finish
      puts "###############################################################"
    rescue DBI::DatabaseError => e
      puts "Database error code=#{e.err} #{e.errstr}"
    end
  end

  # --------------------------------------------------------------------------------
  # Test basic database accesses
  # --------------------------------------------------------------------------------
  def select_one(dbh, query)
    # read all
    puts "==============================================================="
    begin
      sth = dbh.execute(query)
      rows = sth.fetch_all
      count = rows.count
      
      if (count > 0)
        return rows[0]
      else
        return nill
      end

      sth.finish
      puts "==============================================================="
    rescue DBI::DatabaseError => e
      puts "Database error code=#{e.err} #{e.errstr}"
    end
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
      # puts "<<<<SongName = \"#{row[0]}\", SongLength_s = \"#{row[1]}\""
    end

    # Read everything with details
    select_all(@dbh, 'select * from simple01;')

    # Read one
    res = select_one(@dbh, 'select * from simple01 where SongName="Song 5";')
    puts "row = #{res[0]}, #{res[1]}"
    
    select_one(@dbh, 'select * from simple02')

    # Don't prepare, just do it!
    @dbh.do('delete from simple01')
  end

end