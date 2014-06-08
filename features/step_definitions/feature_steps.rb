$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')

require 'elocalculator'

Before do
  @calc = Elocalculator.new
end

When(/^there is no html already$/) do
  @calc.html_exist
end

Then(/^get the html$/) do
  @calc.download_html
end

Then(/^the html should be there$/) do
  @calc.html_exist
end
