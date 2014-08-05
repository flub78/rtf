# Ruby Sets management
#
# Utility class used to handle ranges, merge them, etc.
#
# This class handles discontinuated ranges, there are a collection of ranges with
# a lower and higher element.
#
# Basic operations include, generation method, merge, interserction and
# the check that an element belongs or not to the range.
#
# API Example
#
#    @left = Range.new([100..200, 300..400]);
#    @right = Range.new([150..250, 350..450]);
#
#    my $union = $left + $right;
#    my $intersection = $left * $right;
#
#    print $left . " union " . $right . " = " . $union . "\n";
#    print $left . " intersection " . $right . " = " . $intersection . "\n";
#
# Implementation
#
# Internaly a range is managed as an ordered list of Ruby ranges. 

# Define a special equality for Ruby ranges
class Range
  
  # Redefine a new equal
  def equal?(other_range)
    
    if (self.begin != other_range.begin)
      return false
    end

    # same range end
    if (self.exclude_end? == other_range.exclude_end?)
      if (self.end != other_range.end)
        return false
      end
    end

    # different range end
    if (self.exclude_end? and (self.end.pred != other_range.end))
      return false
    end

    if (other_range.exclude_end? and (self.end.succ != other_range.end))
      return false
    end

    return true
  end
end

# Multiple section ranges
class Ranges
  # Constructor
  def initialize(content)
    @content = []

    content.each do |elt|
      if (!elt.is_a?(Range))
        raise "Not a range"
      end

      range_start = elt.begin
      range_end = elt.end

      if (@elt_class)
        raise "Ranges mismatch" unless (range_start.is_a?(@elt_class))
      else
        @elt_class = range_start.class
      end

      self.add(elt)
    end
  end

  # Image
  def to_s
    return @content.to_s
  end

  # check if a subrange is in the range
  def include?(val)
    return @content.include?(val)
  end

  # check if an element is in the range
  def member?(val)
    # puts "@content #{@content.inspect}"
    @content.each do |subrange|
      # puts "subrange #{subrange.inspect}"
      if (subrange.member?(val))
        return true
      end
    end
    return false
  end

  # returns the number of subranges
  def size()
    return @content.size()
  end

  # add a subrange
  def add(elt)
    if (!self.include?(elt))
      @content << elt
    end
    @content.sort!{|a, b| a.first <=> b.first}
  end

  # remove a subrange
  def delete(elt)
    if (self.include?(elt))
      @content.delete(elt)
    end
  end

  # overwrite equality
  def ==(other_range)
    # The following line does not work because 6..6 != 6...7
    # return @content == other_range.content

    i = 0
    @content.each do |subrange|
      other_subrange = other_range.content[i]
      i += 1

      if (!subrange.equal?(other_subrange))
        return false
      end
      
    end #each

    return true

  end

  # Protected section
  protected

  # getter
  def content
    @content
  end

end
