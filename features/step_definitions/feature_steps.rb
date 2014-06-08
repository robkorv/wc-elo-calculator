$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')

require 'elocalculator'

Before do
  @calc = Elocalculator.new
end

# Feature: Get elo scores
When(/^there is no html already$/) do
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
  pending # express the regexp above with the code you wish you had
end

Then(/^parse the elorating$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I will have an object with the score per country$/) do
  pending # express the regexp above with the code you wish you had
end
