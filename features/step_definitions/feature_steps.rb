@test_hash = {
  'Brazil'                 => 2113,
  'Spain'                  => 2086,
  'Germany'                => 2046,
  'Argentina'              => 1989,
  'Netherlands'            => 1959,
  'England'                => 1914,
  'Portugal'               => 1902,
  'Colombia'               => 1897,
  'Uruguay'                => 1895,
  'Chile'                  => 1895,
  'Italy'                  => 1879,
  'France'                 => 1869,
  'United States'          => 1832,
  'Belgium'                => 1824,
  'Russia'                 => 1821,
  'Mexico'                 => 1820,
  'Switzerland'            => 1820,
  'Ecuador'                => 1813,
  'Greece'                 => 1796,
  'Croatia'                => 1787,
  'Ivory Coast'            => 1778,
  'Japan'                  => 1753,
  'Bosnia and Herzegovina' => 1751,
  'Nigeria'                => 1719,
  'Costa Rica'             => 1707,
  'Australia'              => 1699,
  'Iran'                   => 1695,
  'Ghana'                  => 1687,
  'South Korea'            => 1673,
  'Honduras'               => 1642,
  'Algeria'                => 1609,
  'Cameroon'               => 1602
}

Before do
  @calc = Elocalculator.new
end

# Feature: Get elo scores
When(/^there is no elorating$/) do
  expect(@calc.html_exist).to be false
end

Then(/^get the html$/) do
  @calc.download_html
end

Then(/^the html should be there$/) do
  expect(@calc.html_exist).to be true
end

# Feature: Parse elo scores
Given(/^there is a test set$/) do
  @calc.html_file = 'test/eloratings.html'
  expect(@calc.html_exist).to be true
end

Then(/^parse the elorating$/) do
  @calc.parse_html
  expect(@calc.html_doc.css('title').to_s)
  .to include('World Football Elo Ratings')
end

Then(/^search the dom for the ratings table$/) do
  @calc.search_dom
  expect(@calc.found_html.to_s).to include('table')
end

Then(/^find a way to read the values$/) do
  @calc.read_values
  expect(@calc.elo_hash).to be_truthy
end

Then(/^create an object with the score per country$/) do
  expect(@calc.elo_hash).to be_an_instance_of(Hash)
end

# Feature: Calculate the match outcome
Given(/^there is a (\d+)\.(\d+) average goals per match$/) do |arg1, arg2|
  expect(@calc.avg_goals).to eq("#{arg1}.#{arg2}".to_f)
end

Then(/^the highest rating scores ~(\d+) goals against the lowest$/) do |arg1|
  puts arg1
  pending # express the regexp above with the code you wish you had
end

Then(/^every other match will be derived from that$/) do
  pending # express the regexp above with the code you wish you had
end
