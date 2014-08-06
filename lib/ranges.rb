# Ruby Ranges management

##############################################################################
# Define a special equality for Ruby ranges
##############################################################################
class Range
  ##############################################################################
  # Redefine a new equal
  # making x..y == x...z when z == y.succ
  ##############################################################################
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

##############################################################################
# Multiple section ranges
#
# This class handles discontinuated ranges, there are a collection of ranges with
# a lower and higher element.
#
# Basic operations include, generation method, merge, interserction and
# the check that an element belongs or not to the range.
#
# API Example
#
#    left = Range.new([100..200, 300..400]);
#    right = Range.new([150..250, 350..450]);
#
#    union = left + right;
#    intersection = left * $right;
#
# Implementation
#
# Internaly a range is managed as an ordered list of Ruby ranges.
##############################################################################
class Ranges
  ##############################################################################
  # Constructor
  ##############################################################################
  def initialize(content = [])
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

  ##############################################################################
  # Image
  ##############################################################################
  def to_s
    return @content.to_s
  end

  ##############################################################################
  # check if a subrange is in the range
  ##############################################################################
  def include?(val)
    return @content.include?(val)
  end

  ##############################################################################
  # check if an element is in the range
  ##############################################################################
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

  ##############################################################################
  # returns the number of subranges
  ##############################################################################
  def section_number()
    return @content.size()
  end

  ##############################################################################
  # returns the number of elements
  ##############################################################################
  def size()
    size = 0
    @content.each {|subrange| size += subrange.size()}
    size
  end

  ##############################################################################
  # add a subrange
  ##############################################################################
  def add(elt)
    if (!self.include?(elt))
      @content << elt
    end
    @content.sort!{|a, b| a.first <=> b.first}
    # self.normalize!
  end

  ##############################################################################
  # remove a subrange
  ##############################################################################
  def delete(elt)
    if (self.include?(elt))
      @content.delete(elt)
    end
  end

  ##############################################################################
  # overwrite equality
  ##############################################################################
  def ==(other_range)
    a = self.normalize
    return a.equal(other_range.normalize)
  end

  ##############################################################################
  # iterator
  ##############################################################################
  def each (&blk)
    @content.each do |subrange|
      subrange.each(&blk)
    end
  end

  ##############################################################################
  # append operator
  ##############################################################################
  def << (elt)
    # nothing to do if the element is already in the range
    if (self.member?(elt))
      return
    end

    if (self.size == 0)
      # first subrange
      self.add(elt..elt)
      return
    end

    i = 0
    included = false
    @content.each do |subrange|

      # if the new element must be included before
      if (elt < subrange.begin)
        if (elt.succ == subrange.begin)
          # modify the range
          @content[i] = elt .. subrange.end
          included = true
          break
        else
          self.add(elt..elt)
          included = true
          break
        end
      end
      i += 1
    end #each

    # if the new element must be included after
    if (!included)
      @content.push(elt..elt)
    end

    self.normalize!

  end

  ##############################################################################
  # merge adjacent sub ranges
  ##############################################################################
  def normalize!

    previous = nil
    @tmp = []
    @content.each do |subrange|

      if (previous == nil)
        previous = subrange

      elsif (!previous.exclude_end? && (previous.end.succ == subrange.begin) )
        # adjacent ranges
        previous = Range.new(previous.begin, subrange.end, subrange.exclude_end?)

      elsif (previous.exclude_end? && (previous.end == subrange.begin) )
        # adjacent ranges
        previous = Range.new(previous.begin, subrange.end, subrange.exclude_end?)

      else
        @tmp.push previous
        previous = subrange
      end
    end

    if (previous != nil)
      @tmp.push previous
    end

    @content = @tmp

  end

  ##############################################################################
  # union
  ##############################################################################
  def +(other)
    res = self
    other.each do |elt|
      res << elt
    end
    return res
  end

  ##############################################################################
  # intersection
  ##############################################################################
  def *(other)
    res = Ranges.new
    other.each do |elt|
      if (self.member?(elt))
        res << elt
      end
    end
    return res
  end

  ##############################################################################
  # return a normalized copy
  ##############################################################################
  def normalize
    obj = self
    obj.normalize!
    return obj
  end

  ##############################################################################
  # Protected section
  ##############################################################################
  protected

  ##############################################################################
  # getter
  ##############################################################################
  def content
    @content
  end

  ##############################################################################
  # equality
  ##############################################################################
  def equal(other_range)
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

end
