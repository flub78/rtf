require 'minitest/autorun'
# require 'watir' to drive IE on windows	
require 'watir-webdriver'	# to drive Firefox
require 'os.rb'
require 'headless' if !OS.windows?

# This is an example of WEB application test using WATIR
#
# sudo gem install  watir-webdriver
# sudo gem install headless
# sudo apt-get install xvfb (ubuntu, debian)
# sudo yum install xorg-x11-server-Xvfb (fedora)
# class TestWebSite <MiniTest::Unit::TestCase
class TestWebSite < Minitest::Test


  # To force alphabetical order.
  # But having tests dependent on that is not recommended
  # def self.test_order
  #  :alpha
  # end   
  
  def initialize(args)
    super(args)
    puts "\n# Suite " + self.class.name + "\n"
  end
  
  
  # Code that run before each test
  def setup
    if !OS.windows? && !ENV['DISPLAY_TESTS']
      @headless = Headless.new
      @headless.start
    end
    @browser = Watir::Browser.new
  end
  
  # Code that runs after each test
  def teardown
    @browser.close
    @headless.destroy if (!OS.windows? && !ENV['DISPLAY_TESTS'])
  end
  
  # save a screenshot
  def screenshot(filename)
    fn = ENV['RTF'] + '/tests/screenshots/' + filename
    File.delete(fn) if File.exist?(fn)
    assert(!File.exist?(fn), filename + " screenshot deleted")
    @browser.screenshot.save(fn)
    assert(File.exist?(fn), filename + " screenshot created")    
  end
  
  # test about the Goole page
  def test_there_should_be_text_About_Google
    @browser.goto("http://www.google.com")
    assert(@browser.text.include?("Google"))
    screenshot('google.png')
        
  end
  
  # test names must start by test_ or they will not be executed
  def test_watir_example
    @browser.goto("http://bit.ly/watir-example")
    assert(@browser.text.include?("Example"))
	
    # setting a text field
    @browser.text_field(:id => 'entry_1000000').set 'Watir'
	
    @browser.textarea(:id => 'entry_1000001').set "I come here from Australia. \n The weather is great here."
    screenshot('watir.png')
    
    @browser.radio(:value => 'Watir').set
    
    @browser.checkbox(:value => 'Ruby').set
    @browser.checkbox(:value => 'Python').set
    
    @browser.button(:name => 'submit').click
     
    puts @browser.text.include? 'Your response has been recorded.'
    
  rescue Timeout::Error => e
      puts "Timeout error code=#{e.err} #{e.errstr}"
      assert(false, "Timeout on watir example")
  end
  
end
