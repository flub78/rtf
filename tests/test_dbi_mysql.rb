#!/usr/bin/env ruby
require File.dirname(__FILE__) + '/my_test.rb'
require 'dbi'

# Simple example of sqlite access
# sudo gem install dbi
# sudo gem install dbd-sqlite3
# sudo gem install dbd-mysql
class TestDBIMysql < MyMiniTest
  
  def initialize(args)
    super(args)
  end
  

  # --------------------------------------------------------------------------------
  # Before each test
  # --------------------------------------------------------------------------------
  def setup

    @db_type = "mysql"
    # @db_type = "sqlite"

    if (@db_type == "mysql")
      # mysql --user=testuser --password=testpwd
      # use test;
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

=begin
    mysql> show tables;
    +----------------+
    | Tables_in_test |
    +----------------+
    | simple01       |
    +----------------+
=end

    @dbh.do(sql)

    if (@db_type == "mysql")
      row = @dbh.select_one("SELECT VERSION()")
      puts "Mysql server version: " + row[0]
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
    begin
      sth = dbh.prepare(query)
      sth.execute
            
      rows = []
      # There is a bug in ruby dbi fetch_all for mysql
      while row=sth.fetch do
        rows << Array.new(row)
      end
      
      sth.finish
      return rows
    rescue DBI::DatabaseError => e
      puts "Database error code=#{e.err} #{e.errstr}"
    end
  end

  # --------------------------------------------------------------------------------
  # Test basic database accesses
  # --------------------------------------------------------------------------------
  def select_one(dbh, query)
    # read all
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
    rescue DBI::DatabaseError => e
      puts "Database error code=#{e.err} #{e.errstr}"
    end
  end

  # --------------------------------------------------------------------------------
  # Test basic database accesses
  # --------------------------------------------------------------------------------
  def test_basic
    description('basic database queries')
    assert(@dbh, "Connected to database")

    row = @dbh.select_one("SELECT COUNT(*) FROM simple01;")
    initial_count = row[0]

    # Insert some rows, use placeholders
    1.upto(13) do |i|
      sql = "insert into simple01 (SongName, SongLength_s) VALUES (?, ?)"
      @dbh.do(sql, "Song #{i}", "#{i*10}")
    end

    query = 'select * from simple01'

    rows = self.select_all(@dbh,query)
    puts "#\tExample of select\n"   
    rows.each do |row|
      puts "#{row[0]} =>  #{row[1]}\n"      
    end
    
    row = @dbh.select_one("SELECT COUNT(*) FROM simple01;")
    count = row[0]
    assert(count == initial_count + 13, "Correct number of created elements")

    # Close the statement handle when done

    # Don't prepare, just do it!
    @dbh.do('delete from simple01')

    row = @dbh.select_one("SELECT COUNT(*) FROM simple01;")
    count = row[0]
    assert(count == 0, "all elements have been deleted")

  end

  # --------------------------------------------------------------------------------
  # Test access to information_schema tables
  # --------------------------------------------------------------------------------
  def test_views
    description('basic views operation', 'called by user', 'an existing test database')
    assert(@dbh, "Connected to database")

    row = @dbh.select_one("SELECT COUNT(*) FROM information_schema.views;")
    puts "Number of views = #{row[0]}\n"

    sth = @dbh.prepare('select * from information_schema.views')
    sth.execute
    # Print out each row
    while row=sth.fetch do
      puts "#{row[2]} =>  #{row[3]}\n\n"
    end

    # Close the statement handle when done
    sth.finish

  end
  
  
  # --------------------------------------------------------------------------------
  # Test access to information_schema tables
  # --------------------------------------------------------------------------------
  def test_schema
    
    description('operations on database schema')
    # list of table
    puts "#\tList of tables:\n"
    schema = 'ci3'
    sth = @dbh.prepare("SELECT *  FROM information_schema.`TABLES` WHERE `TABLE_SCHEMA` LIKE 'ci3'")
    sth.execute
    # Print out each row
    while row=sth.fetch do
      puts "#{row[2]}, "
     end
     puts "\n"
    sth.finish

  end

end