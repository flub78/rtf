# Extract metadata information from a Mysql database

require "metadata"


##############################################################################
# Manage field information
##############################################################################
class FieldInfo
  
  # constructor
  def initialize(args={})
    @metadata = args[:metadata]
    @database = args[:database]
    @table = args[:table]
    @field = args[:field]
      
    # Hash with the keys:
    # :table, :field, :default, :allow_null, :type, :is_primary, :is_foreign, :auto_increment,
    # :comment
    @info = $metadata.field_info(database, table, field)
    @foreign_key = $metadata.foreign_key(database, table, field)
    @reference = $metadata.reference(database, table, field)
  end
    
  # --------------------------------------------------------------------------------
  # returns the field information on a field
  # --------------------------------------------------------------------------------
  def display(database, table, field)
    return "display(#{database}, #{table}, #{field})"
  end

# --------------------------------------------------------------------------------
# returns the field information on a field
# --------------------------------------------------------------------------------
def input(database, table, field)
  return "input(#{database}, #{table}, #{field})"
end

# --------------------------------------------------------------------------------
# returns the field information on a field
# --------------------------------------------------------------------------------
def rules(database, table, field)
  return "rules(#{database}, #{table}, #{field})"
end

# --------------------------------------------------------------------------------
# returns the field information on a field
# --------------------------------------------------------------------------------
def field_basic_type(database, table, field)
  return "field_basic_type(#{database}, #{table}, #{field})"
end

end