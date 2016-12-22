# Class template

##############################################################################
# Define a class
##############################################################################
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
  
  # method
  def hello(name)
    puts "Hello " + name
  end
  
  ##############################################################################
  # Protected section
  ##############################################################################
  protected

  # method
  def protected_hello(name)
    puts "Protected hello " + name
  end

end