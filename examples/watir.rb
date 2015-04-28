gem "minitest"
require 'minitest/autorun'
require "minitest/ci"
require 'watir-webdriver'

url = 'http://www.test.gvv.planeur-abbeville.fr/'

@b = Watir::Browser.new
@b.window.resize_to(1200, 900)

@b.goto url

@b.text_field(:id => 'username').set 'testadmin'
@b.text_field(:id => 'password').set 'password'
@b.button(:name => 'login').click

@b.text.include?("planeur")

@b.checkbox(:id => 'no_mod').click  # checkbox selection
@b.button(:id => 'close_mod_dialog').click