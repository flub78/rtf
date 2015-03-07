require 'minitest/autorun'
# require 'watir' to drive IE on windows	
require 'watir-webdriver'	# to drive Firefox
class GoogleHomePage <MiniTest::Unit::TestCase

  # To force alphabetical order.
  # But having tests dependent on that is not recommended
  # def self.test_order
  #  :alpha
  # end   
  
  # Code that run before each test
  def setup
  end
  
  # Code that runs after each test
  def teardown
  end
  
  def test_there_should_be_text_About_Google
    browser = Watir::Browser.new
    browser.goto("http://www.google.com")
    assert(browser.text.include?("Google"))
  end
  
  # test names must start by test_ or they will not be executed
  def test_2
    browser = Watir::Browser.new
    browser.goto("http://bit.ly/watir-example")
    assert(browser.text.include?("Example"))
	
	# setting a text field
	browser.text_field(:id => 'entry_1000000').set 'Watir'
	
	browser.textarea(:id => 'entry_1000001').set "I come here from Australia. \n The weather is great here."
	
  end
  
end
