
# Ruby Sets management 
class Set
  
  # Constructor
  def initialize(content)
    @content     = content
  end
  
  # Image
  def to_s
    return @content.to_s 
  end
  
  # check if an element is in the set
  def include?(elt)
    return @content.include?(elt)
  end
 
  # returns the size of the set
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
