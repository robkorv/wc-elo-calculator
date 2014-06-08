$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')

require 'elocalculator'

Before do
  @calc = Elocalculator.new
end

# Feature: Get elo scores
When(/^there is no elorating$/) do
  @calc.html_exist
end

Then(/^get the html$/) do
  @calc.download_html
end

Then(/^the html should be there$/) do
  @calc.html_exist
end

# Feature: Parse elo scores
Given(/^there is a test set$/) do
  @calc.html_file = 'test/eloratings.html'
  @calc.html_exist
end

Then(/^parse the elorating$/) do
  @calc.parse_html
end

Then(/^search the dom for the ratings table$/) do
  @calc.search_dom
end

Then(/^find a way to read the values$/) do
  @calc.read_values
end

Then(/^create an object with the score per country$/) do
  puts  @calc.elo_hash
end
