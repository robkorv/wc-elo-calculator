$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')

require 'elocalculator'

Before do
  @calc = Elocalculator.new
end

When(/^there is no html already$/) do
  @calc.html_exist
end

Then(/^get the html$/) do
  pending # express the regexp above with the code you wish you had
end
