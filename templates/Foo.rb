class Foo
  
  # constructor
  def initialize(args={})
    @bar = args[:bar]
  end
  
  # getter
  def bar
    @bar
  end
  
  # setter
  def bar=(newval)
    @bar = newval
  end
end