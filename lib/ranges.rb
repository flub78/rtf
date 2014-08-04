
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
# Internaly a range is managed as an ordered list of boundaries.  They are the limits of the segments.  They are two flags for each boundary to specify if they are the beginnning or the end of a segment.
# Example
#
#    The segment 10..15, 16..20, 50..50, 100..150
#    will be manage in the following list
#
#    value   isStart isEnd   End
#     10     true    false    20
#     20     false   true
#     50     true    true     50
#    100     true    false   150
#    150     false   true 
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
#    puts "@content #{@content.inspect}"

    @content.each do |subrange|
#      puts "subrange #{subrange.inspect}"
      if (subrange.member?(val))
        return true
      end
    end
    return false
  end
 
  # returns the number of sub ranges
  def size()
    return @content.size()
  end

  # add a new element
  def add(elt)
    if (!self.include?(elt))
      @content << elt
    end
  end

  # remove an element
  def delete(elt)
    if (self.include?(elt))
      @content.delete(elt)
    end
  end
 
end
