require 'minitest/autorun'
# require 'watir' to drive IE on windows	
require 'watir-webdriver'	# to drive Firefox
require 'headless'

# This is an example of WEB application test using WATIR
#
# sudo gem install  watir-webdriver
# sudo gem install headless
# sudo apt-get install xvfb (ubuntu, debian)
# sudo yum install xorg-x11-server-Xvfb (fedora)
class GoogleHomePage <MiniTest::Unit::TestCase

  # To force alphabetical order.
  # But having tests dependent on that is not recommended
  # def self.test_order
  #  :alpha
  # end   
  
  # Code that run before each test
  def setup
    @headless = Headless.new
    @headless.start
    @browser = Watir::Browser.new
  end
  
  # Code that runs after each test
  def teardown
    @browser.close
    @headless.destroy
  end
  
  def screenshot(filename)
    File.delete(filename) if File.exist?(filename)
    assert(!File.exist?(filename), filename + " screenshot deleted")
    @browser.screenshot.save(filename)
    assert(File.exist?(filename), filename + " screenshot created")    
  end
  
  def test_there_should_be_text_About_Google
    @browser.goto("http://www.google.com")
    assert(@browser.text.include?("Google"))
    screenshot('screenshots/google.png')
  end
  
  # test names must start by test_ or they will not be executed
  def test_2
    @browser.goto("http://bit.ly/watir-example")
    assert(@browser.text.include?("Example"))
	
    # setting a text field
    @browser.text_field(:id => 'entry_1000000').set 'Watir'
	
    @browser.textarea(:id => 'entry_1000001').set "I come here from Australia. \n The weather is great here."
    screenshot('screenshots/watir.png')
  end
  
end
