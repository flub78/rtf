# Extract metadata information from a Mysql database

require 'dbi'

##############################################################################
# Extract list of table, list of fields, list of views, fields information
# from a MySql database
##############################################################################
class Metadata
  # constructor
  def initialize(args={})
    @dbdriver = args[:dbdriver]
    @database = args[:database]
    @user = args[:user]
    @password = args[:password]
    @dbh = DBI.connect(@dbdriver, @user, @password)
  end

  # --------------------------------------------------------------------------------
  # Return the list of tables
  # --------------------------------------------------------------------------------
  def tables
    query = "SELECT TABLE_NAME FROM information_schema.`TABLES` WHERE `TABLE_SCHEMA` LIKE '#{@database}'"
    return self.select_col(query,0)
  end

  # --------------------------------------------------------------------------------
  # returns the list of fields for a table
  # --------------------------------------------------------------------------------
  def fields(table)
    query = "SELECT COLUMN_NAME FROM information_schema.`COLUMNS` WHERE TABLE_NAME = '#{table}'"
    return self.select_col(query,0)
  end

  # --------------------------------------------------------------------------------
  # returns the field information on a field
  # --------------------------------------------------------------------------------
  def field_info(table, field)
    query = "SELECT TABLE_NAME,COLUMN_NAME,COLUMN_DEFAULT,IS_NULLABLE,COLUMN_TYPE,COLUMN_KEY,EXTRA,COLUMN_COMMENT"
    query += " FROM information_schema.`COLUMNS` WHERE TABLE_NAME = '#{table}' and COLUMN_NAME = '#{field}'"
    selection = self.select_all(query)

    selection.each do |row|
      info = {:table => row[0], :field => row[1], :default => row[2],
        :allow_null => (row[3] == "YES"),
        :type => row[4],
        :is_primary => (row[5] == "PRI"),
        :is_foreign => (row[5] == "MUL"),
        :auto_increment => (row[6] == "auto_increment"),
        :comment => row[7]}
      return info
    end
  end

  # --------------------------------------------------------------------------------
  # returns the list of views
  # --------------------------------------------------------------------------------
  def views
    query = "SELECT TABLE_NAME FROM information_schema.`VIEWS` WHERE `TABLE_SCHEMA` LIKE '#{@database}'"
    return self.select_col(query,0)
  end

  # --------------------------------------------------------------------------------
  # true if a table is a view
  # false for non view and unknown tables
  # --------------------------------------------------------------------------------
  def is_view?(table)
    query = "SELECT TABLE_NAME FROM information_schema.`VIEWS` WHERE `TABLE_SCHEMA`='#{@database}' and `TABLE_NAME`='#{table}'"
    select = self.select_col(query,0)
    return (select.count() > 0)
  end

  # --------------------------------------------------------------------------------
  # if a field is a foreign key returns information on the referenced table and field
  # --------------------------------------------------------------------------------
  def foreign_key(table, field)
    query = "SELECT REFERENCED_TABLE_SCHEMA,REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME  FROM information_schema.`KEY_COLUMN_USAGE` "
    query += "WHERE `TABLE_SCHEMA`='#{@database}' and `TABLE_NAME`='#{table}' and `COLUMN_NAME`='#{field}' "
    
    selection = self.select_all(query)
    
    if (selection.count < 1)
      return {
        :database => nil,
        :table => nil,
        :field => nil}
    end
    
    result = {
      :database => selection[0][0],
      :table => selection[0][1],
      :field => selection[0][2]}
    return result
  end

  # --------------------------------------------------------------------------------
  # true for foreign keys 
  # --------------------------------------------------------------------------------
  def is_foreign_key?(table, field)
    query = "SELECT REFERENCED_TABLE_SCHEMA,REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME  FROM information_schema.`KEY_COLUMN_USAGE` "
    query += "WHERE `TABLE_SCHEMA`='#{@database}' and `TABLE_NAME`='#{table}' and `COLUMN_NAME`='#{field}' "
    
    selection = self.select_all(query)
    return selection[0][0]
  end
  
  # --------------------------------------------------------------------------------
  # returns the table and field pointed by a view
  # --------------------------------------------------------------------------------
  def reference(view, field)
    if (! self.is_view?(view))
      return [view, field]
    end
    
    query = "SELECT TABLE_NAME,VIEW_DEFINITION FROM information_schema.`VIEWS` WHERE `TABLE_SCHEMA`='#{@database}' and `TABLE_NAME`='#{view}'"
    res = self.select_one(query)

    select = res[1]

    # remove select and from
    if (matches = /select\s(.*)\sfrom.*$/.match(select))
      definition = matches[1].to_s + ','
      list = definition.scan(/(.*?)\sAS\s(.*?)\,/)
      
      list.each do |item|
        key = item[1]
        defn = item[0]
        split = defn.split(/\./)
        if (split.count == 3)
          # it is a definition
          database = split[0].tr('`','')
          table = split[1].tr('`','')
          fld = split[2].tr('`','')
          # puts key + " =>    " + table + '---' + fld + "\n"
          if (fld == field)
            return [table, fld]
          end
        end
      end
    end
    return [view, field]
  end

  ##############################################################################
  # Protected section
  ##############################################################################
  protected

  # --------------------------------------------------------------------------------
  # Returns a select as an array
  # --------------------------------------------------------------------------------
  def select_all(query)
    # read all
    begin
      sth = @dbh.prepare(query)
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
  
  def select_one(query)
    all = self.select_all(query)
    return all[0]
  end

  # Return the list of tables
  def select_col(query, column)
    selection = self.select_all(query)

    list = []
    selection.each do |row|
      list << row[column]
    end
    return list
  end

end